memo = []
memos = Memo.where(user_id:nil)
(memos).each do |memo|
  memo = Memo.find(memo.id)
  if memo.present?
    memo.user_id = 1
    memo.save
  end
end

memos = []
memos = Memo.where(important:nil)
(memos).each do |memo|
  memo = Memo.find(memo.id)
  if memo.present?
    memo.important = false
    memo.save
  end
end

memos = []
memos = Memo.where(twitter:nil)
(memos).each do |memo|
  memo = Memo.find(memo.id)
  if memo.present?
    memo.twitter = false
    memo.save
  end
end

memos = []
memos = Memo.where(public:nil)
(memos).each do |memo|
  memo = Memo.find(memo.id)
  if memo.present?
    memo.public = false
    memo.save
  end
end
