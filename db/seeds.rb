memo = []
memos = Memo.where(user_id:nil)
(memos).each do |memo|
  memo = Memo.find(memo.id)
  if memo.present?
    memo.user_id = 1
    memo.save
  end
end
