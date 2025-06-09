import { Controller } from "@hotwired/stimulus";

class ShopController extends Controller {
  static scriptURL = "https://sdks.shopifycdn.com/buy-button/latest/buy-button-storefront.min.js"

  connect() {
    if (window.ShopifyBuy) {
      if (window.ShopifyBuy.UI) {
        this.shopifyBuyInit();
      } else {
        this.loadScript();
      }
    } else {
      this.loadScript();
    }
  }

  loadScript() {
    var script = document.createElement("script");
    script.async = true;
    script.src = ShopController.scriptURL;
    (document.getElementsByTagName("head")[0] || document.getElementsByTagName("body")[0]).appendChild(script);
    script.onload = this.shopifyBuyInit;
  }

  shopifyBuyInit() {
    const products = [
      {
        id: "6857234743396",
        domId: "product-component-1654687279319"
      },
      {
        id: "6859110645860",
        domId: "product-component-1654691987347"
      }
    ]

    var client = ShopifyBuy.buildClient({
      domain: "shop.grubdaily.com",
      storefrontAccessToken: "d593bab5d4641fee80a6c259e56fb318",
    });

    products.forEach(product => {
      ShopifyBuy.UI.onReady(client).then(function (ui) {
        ui.createComponent('product', {
          id: product.id,
          node: document.getElementById(product.domId),
          moneyFormat: "%C2%A3%7B%7Bamount%7D%7D",
          options: {
            "product": {
              "styles": {
                "product": {
                  "@media (min-width: 601px)": {
                    "max-width": "calc(25% - 20px)",
                    "margin-left": "20px",
                    "margin-bottom": "50px"
                  }
                }
              },
              "text": {
                "button": "Add to cart"
              }
            },
            "productSet": {
              "styles": {
                "products": {
                  "@media (min-width: 601px)": {
                    "margin-left": "-20px"
                  }
                }
              }
            },
            "modalProduct": {
              "contents": {
                "img": false,
                "imgWithCarousel": true,
                "button": false,
                "buttonWithQuantity": true
              },
              "styles": {
                "product": {
                  "@media (min-width: 601px)": {
                    "max-width": "100%",
                    "margin-left": "0px",
                    "margin-bottom": "0px"
                  }
                }
              },
              "text": {
                "button": "Add to cart"
              }
            },
            "option": {},
            "cart": {
              "text": {
                "total": "Subtotal",
                "button": "Checkout"
              }
            },
            "toggle": {}
          },
        });
      });
    })
  }
}

export default ShopController;
