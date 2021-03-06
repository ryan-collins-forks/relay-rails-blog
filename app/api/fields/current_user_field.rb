CurrentUserField = GraphQL::Field.define do
  name('current_user')
  type(UserType)
  description  'Returns current signed in user object'
  resolve -> (obj, args, ctx) {
    ctx[:current_user] ? ctx[:current_user] : nil
  }
end
