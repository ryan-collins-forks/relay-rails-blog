module VoteMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateVote'

    input_field :votable_id, !types.ID

    return_field :post, PostType
    return_field :comment, CommentType

    resolve -> (inputs, ctx) {
      votable = NodeIdentification.object_from_id(inputs[:votable_id], ctx)
      user = ctx[:current_user]
      votable.votes.create({
        user: user
      })

      { votable.class.to_s.downcase.to_sym => votable.reload }

    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyVote'

    input_field :votable_id, !types.ID

    return_field :post, PostType
    return_field :comment, CommentType

    resolve -> (inputs, ctx) {
      votable = NodeIdentification.object_from_id(inputs[:votable_id], ctx)
      user = ctx[:current_user]
      vote = user.votes.where({
        votable: votable
      }).first

      vote.destroy

      { vote.votable_type.downcase.to_sym => votable.reload  }
    }
  end
end
