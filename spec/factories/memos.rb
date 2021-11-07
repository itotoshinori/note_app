FactoryBot.define do
    factory :memo do
        description    {"test"}
        complete       {false}
        twitter        {false}
        public         {false}
        user_id        {1}
        link           {'http://yahoo.co.jp'}
    end
  end