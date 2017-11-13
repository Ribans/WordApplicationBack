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

## API(GET)

### 覚えるパート(暗記)

`$URL/learn `

叩くと、id,english,japaneseを頂ける

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

`$URL/challenge`

叩くとAnkimoタンクに蓄積されているデータから問題が出題される
(要: login) ログインしていない場合は `401` を返却

例:
~~~json
{
    id: 1,
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


## トレーニング

`$URL/training`

4単語以上ankimoタンクに蓄積されていないと `403` を返却する
また、ログインしていない場合 `401` を返す

例:

~~~json
{
    id: 160,
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

### Ankimoタンクの取得
`$URL/tank-rate`
ログインしているユーザーのankimoタンクデータを返却する
ログインしていない場合は `401` を返却

~~~json
{
    動詞: {
    base: 679,
       learned: 16
    },
    名詞: {
        base: 856,
        learned: 16
    },
    接続詞: {
        base: 486,
        learned: 4
    }
}
~~~

## API(POST)

### Ankimoタンクへ蓄積
`$url/rememvered`

~~~json
{
    user_id: integer,
    word_id: integer
}
~~~

返却:

~~~ json
{status: 200} //成功時

{status: 500} //失敗時
~~~

### ankimoタンクから削除
`$URL/forgot`

「忘れた。」のときにPOSTするとankimoタンクから削除する

~~~json
{
    user_id: integer,
    word_id: integer
}
~~~

返却:
~~~ json
{status: 200} //成功時

{status: 500} //失敗時
~~~
