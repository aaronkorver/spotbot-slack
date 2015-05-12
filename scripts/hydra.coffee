# Description:
#   Hail Hydra!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hail hydra - displays a random hail hydra image
#
# Author:
#   Kevin Behrens

hails= [
  "http://31.media.tumblr.com/47df4d135cd0e351743e2b2a763940f1/tumblr_inline_n3yxqvbZM51rjdz5i.png",
  "http://cdn.screenrant.com/wp-content/uploads/Say-Hail-Hydra-Again.jpg",
  "http://cdn.smosh.com/sites/default/files/ftpuploads/bloguploads/1013/hail-hydra-captain-america-luigi.jpg",
  "http://comicimpact.com/wp-content/uploads/2014/04/HailHydra2.jpeg",
  "http://data1.whicdn.com/images/110464175/original.jpg",
  "http://designerdaddy.com/site/wp-content/uploads/2014/04/wicked-hydra21.jpg",
  "http://i.imgur.com/yQ16Iq0.png",
  "http://i0.kym-cdn.com/photos/images/newsfeed/000/731/917/0b5.jpg",
  "http://i0.kym-cdn.com/photos/images/newsfeed/000/732/879/f05.jpg",
  "http://i1.wp.com/www.eatgeekplay.com/wp-content/uploads/2014/04/db3-hail-hydra.jpg?resize=536%2C359",
  "http://i2.kym-cdn.com/photos/images/newsfeed/000/731/769/c97.png",
  "http://i2.kym-cdn.com/photos/images/newsfeed/000/731/837/626.jpg",
  "http://images.moviepilot-cdn.com/bkkqu3tiqaefal3-hail-hydra-the-internet-s-newestt-meme-courtesy-of-captain-america-2.jpeg?width=599&height=487",
  "http://sd.keepcalm-o-matic.co.uk/i/hail-hydra-2.png",
  "http://sd.keepcalm-o-matic.co.uk/i/keep-calm-and-hail-hydra-2.png",
  "http://www.fbtb.net/wp-content/uploads/2014/04/Hail-Hydra-6.jpg",
  "http://www.wired.com/wp-content/uploads/2014/04/hail-hydra-ft.jpg",
  "http://www.wired.com/wp-content/uploads/2014/04/sponge.jpg",
  "https://anibundel.files.wordpress.com/2014/04/hail-hydra-5.png",
  "https://anibundel.files.wordpress.com/2014/04/hail-hydra-the-internet-s-newest-meme-courtesy-of-captain-america-2-9aed26f1-794b-4c2b-96af-89ac9e3c9dad.jpeg",
  "https://keithroysdon.files.wordpress.com/2014/04/hail-hydra-bert-and-ernie.jpg?w=625",
  "https://keithroysdon.files.wordpress.com/2014/04/hail-hydra-godfather.jpg",
  "https://uproxx.files.wordpress.com/2014/04/hail-hydra-captain-america-the-winter-soldier-twitter-meme-09.jpg",
  "http://i.imgur.com/m8aXzkY.jpg"
]

module.exports = (robot) ->
  robot.hear /hail ?hydra/i, (msg) ->
    msg.send msg.random hails
