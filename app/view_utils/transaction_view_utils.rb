module TransactionViewUtils
  extend MoneyRails::ActionViewExtension
  extend ActionView::Helpers::TranslationHelper

  MessageBubble = EntityUtils.define_builder(
    [:content, :string, :mandatory],
    [:sender, :hash, :mandatory],
    [:created_at, :time, :mandatory],
    [:mood, one_of: [:positive, :negative, :neutral]]
  )

  module_function

  def merge_messages_and_transitions(messages, transitions)
    messages = messages.map { |msg| MessageBubble[msg] }
    transitions = transitions.map { |tnx| MessageBubble[tnx] }

    (messages + transitions).sort_by { |hash| hash[:created_at] }
  end

  def create_messages_from_actions(transitions, discussion_type, author, starter, payment_sum)
    return [] if transitions.blank?

    previous_states = [nil] + transitions.map { |transition| transition[:to_state] }

    transitions.zip(previous_states).reject { |(transition, previous_state)|
      ["free", "pending"].include? transition[:to_state]
    }.map { |(transition, previous_state)|
      create_message_from_action(transition, previous_state, discussion_type, author, starter, payment_sum)
    }
  end

  def conversation_messages(message_entities)
    message_entities.map { |message_entity| message_entity.merge(mood: :neutral) }
  end

  def transition_messages(transaction, conversation)
    if transaction.present?
      author = MarketplaceService::Conversation::Entity.participant_by_id(conversation, transaction[:listing][:author_id])
      starter = MarketplaceService::Conversation::Entity.participant_by_id(conversation, transaction[:starter_id])

      transitions = transaction[:transitions]
      discussion_type = transaction[:discussion_type]
      payment_sum = transaction[:payment_sum]

      create_messages_from_actions(transitions, discussion_type, author, starter, payment_sum)
    else
      []
    end
  end

  def create_message_from_action(transition, old_state, discussion_type, author, starter, payment_sum)
    preauthorize_accepted = ->(new_state) { new_state == "paid" && old_state == "preauthorized" }
    post_pay_accepted = ->(new_state) { new_state == "paid" }

    message = case transition[:to_state]
    when "preauthorized"
      {
        sender: starter,
        content: t("conversations.message.paid", sum: humanized_money_with_symbol(payment_sum)),
        mood: :positive
      }
    when "accepted"
      {
        sender: author,
        content: t("conversations.message.accepted_#{discussion_type}"),
        mood: :positive
      }
    when "rejected"
      {
        sender: author,
        content: t("conversations.message.rejected_#{discussion_type}"),
        mood: :negative
      }
    when preauthorize_accepted
      {
        sender: author,
        content: t("conversations.message.accepted_#{discussion_type}"),
        mood: :positive
      }
    when post_pay_accepted
      {
        sender: starter,
        content: t("conversations.message.paid", sum: humanized_money_with_symbol(payment_sum)),
        mood: :positive
      }
    when "canceled"
      {
        sender: author,
        content: t("conversations.message.canceled_#{discussion_type}"),
        mood: :negative
      }
    when "confirmed"
      {
        sender: author,
        content: t("conversations.message.confirmed_#{discussion_type}"),
        mood: :positive
      }
    else
      raise("Unknown transition to state: #{transition[:to_state]}")
    end

    MessageBubble[message.merge(created_at: transition[:created_at])]
  end
end
