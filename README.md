# Habrahabr

Клиент для API хабрахабра.

# Usage

```ruby
client = Habrahabr::Client.new(oauth_token: '1234567890abcdef1234567890abcdef12345678', client_id: '1234567890abcdef.12345678')
client.hubs.first
# => {"count_posts"=>3632,
# "count_subscribers"=>116524,
# "is_profiled"=>true,
# "rating"=>1594.3064,
# "alias"=>"infosecurity",
# "title"=>"Информационная безопасность",
# "tags_string"=>
#    "безопасность, фишинг, fishing, защита, взлом, XSS, CSRF, SQL-inj, sql-инъекция, PHP-inj, DoS, DDoS, социальная инженерия, capcha, капча, sql injection, php injection, хакер, хакеры, хакерская атака",
# "about"=>
#    "О том, как мы защищаем свою информацию - от взлома, повреждения, фишинга и т.д. Новости мира anti-virus, anti-spam, anti-spy  и т.д.\r\n\r\nЛичные впечатления, опыт, мнения.",
# "is_membership"=>true,
# "is_company"=>false}

client.hub_habred('infosecurity').first
# => {"id"=>221359,
#  "is_tutorial"=>false,
#  "time_published"=>"2014-04-29T15:52:35+04:00",
#  "time_interesting"=>nil,
#  "comments_count"=>0,
#  "score"=>nil,
#  "votes_count"=>1,
#  "favorites_count"=>5,
#  "tags_string"=>"iso/iec27000, стандарты ИБ, риск-менеджмент",
#  "title"=>"Переход к ISO/IEC 27001:2013. Тонкости перевода и не только",
#  "preview_html"=> ... }
```
