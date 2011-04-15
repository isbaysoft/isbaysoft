module MemoHelper
 def read_memo(identify)
   Memo.get_memo(identify)
 end
end
