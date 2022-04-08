class InfoCoin {
  final String url, name;
  final double price, percent, balance, profit ;
  InfoCoin(this.url, this.name, this.price, this.percent, this.balance, this.profit);

  static List<InfoCoin> getList() {
    List<InfoCoin> coins = <InfoCoin>[];
    coins.add(
      InfoCoin(
          "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Bitcoin-icon.png",
          "BTC",
          39394.14,
          -7.6,
          0,
          0)
    );
    coins.add(
      InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
          "ETH",
          3415.74,
          2.76,
          0,
          0)
    );
    coins.add(
        InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
            "ETH",
            3415.74,
            2.76,
            0,
            0)
    );
    coins.add(
        InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
            "ETH",
            3415.74,
            2.76,
            0,
            0)
    );
    coins.add(
        InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
            "ETH",
            3415.74,
            2.76,
            0,
            0)
    );
    coins.add(
        InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
            "ETH",
            3415.74,
            2.76,
            0,
            0)
    );
    coins.add(
        InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
            "ETH",
            3415.74,
            2.76,
            0,
            0)
    );
    coins.add(
        InfoCoin("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png",
            "ETH",
            3415.74,
            2.76,
            0,
            0)
    );

   return coins;
 }

}