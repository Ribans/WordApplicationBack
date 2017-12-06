# Ankimo Server
> 
Ribans Project

## Build Setup

~~~
$ touch .env # create env file

#install for packages
$ docker-compose run web bundle install -j4 --path vendor/bundle

# setup databse
$ docker-compose run web bundle exec rake db:setup

# launch server
$ docker-compose up
~~~

## API

### 覚えるパート(暗記)

`$URL/learn(GET)`

叩くと、id,english,japaneseが返却される
（jsonの値は完全ランダム)

例:

~~~json
[{
id: 484,
        japanese: "重要な",
        english: "significant"
},
{
id: 1303,
    japanese: "叫ぶ",
    english: "exclaim"
},
{
id: 1923,
    japanese: "突然変異",
    english: "mutation"
},
{
id: 1788,
    japanese: "石油",
    english: "petroleum"
},
{
id: 1803,
    japanese: "陪審員",
    english: "jury"
}]
~~~

### チャレンジパート(実力)

`$URL/challenge(POST)`

叩くとAnkimoタンクに蓄積されているデータから問題が出題される
(要: uid) uid(文字列)を指定していない場合は `401` を返却

CURL例

~~~curl
curl -X POST http://localhost:4567/challenge \
         -H 'Content-Type: application/json' \
         -d '{"uid": "y1a1j4u5u1u4"}'
~~~

返却:
~~~json
{
    id: 1,
    status: 200,
    japanese: "①～続く②～に従う",
    english: "follow",
    dummies: [
        {
            japanese: "①～続く②～に従う",
            english: "follow"
        },
        {
            japanese: "栄える",
            english: "flourish"
        },
        {
            japanese: "① ～ではないかと思う　②〈人・もの〉を疑う",
            english: "suspect"
        },
        {
            japanese: "を理解する",
            english: "comprehend"
        }
    ]
}
~~~

or

~~~json
//401
{message: "uidをjsonで同梱してください"}
~~~

## トレーニング

`$URL/training(POST)`

4単語以上ankimoタンクに蓄積されていないと `403` を返却する
また、uidが同梱されていない場合 `401` を返す

CURL例

~~~curl
curl -X POST http://localhost:4567/training \
         -H 'Content-Type: application/json' \
         -d '{"uid": "y1a1j4u5u1u4"}'
~~~


返却:

~~~json
{
    id: 160,
    status: 200,
    japanese: "由来する",
    english: "derive",
    dummies: [
        {
            id: 160,
            japanese: "由来する",
            english: "derive"
        },
        {
            id: 140,
            japanese: "（～と）述べる",
            english: "remark"
        },
        {
            id: 180,
            japanese: "存在する",
            english: "exist"
        },
        {
            id: 130,
            japanese: "集中する",
            english: "concentrate"
        }
    ]
}
~~~

or

~~~json
// 403
{message: "もっと勉強しましょう"}

//401
{message: "uidをjsonで同梱してください"}
~~~

### Ankimoタンクの取得
`$URL/tank-rate(POST)`
ログインしているユーザーのankimoタンクデータを返却する
ログインしていない場合は `401` を返却

curl

~~~curl
curl -X POST http://localhost:4567/tank-rate \
         -H 'Content-Type: application/json' \
         -d '{"uid": "y1a1j4u5u1u4"}'
~~~

返却

~~~json
{
    verb: {
    base: 679,
       learned: 16
    },
    noun: {
        base: 856,
        learned: 16
    },
    conjunction: {
        base: 486,
        learned: 4
    }
}
~~~

or

~~~json
{ message: "uidをjsonで同梱してください" }
~~~

###単語IDを元にダミーを作る
`$url/create-dummies(POST)`

curl

~~~curl
curl -X POST http://localhost:4567/create-dummies \
         -H 'Content-Type: application/json' \
         -d '{"word_id": 305}'
~~~

json

~~~json
{
    word_id: integer
}
~~~

返却

~~~json
//更新待ち
~~~


### Ankimoタンクへ蓄積
`$url/rememvered(POST)`

curl

~~~curl
curl -X POST http://localhost:4567/remembered \
         -H 'Content-Type: application/json' \
         -d '{"uid": "y1a1j4u5u1u4", "word_id": 305}'
~~~

json

~~~json
{
    user_id: string,
    word_id: integer
}
~~~

返却:

成功時 status 200 を返却

~~~ json
// 失敗時 status 500 を返却
{message: "error message"} //失敗時
~~~

### ankimoタンクから削除
`$URL/forgot(POST)`

「忘れた。」のときにPOSTするとankimoタンクから削除する

curl

~~~curl
curl -X POST http://localhost:4567/forgot \
         -H 'Content-Type: application/json' \
         -d '{"uid": "y1a1j4u5u1u4", "word_id": 305}'
~~~

~~~json
{
    user_id: string,
    word_id: integer
}
~~~

返却:
status 200 //成功時  

status  500 //失敗時
