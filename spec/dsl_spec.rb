require 'spec_helper'

RSpec.describe OrderTransformer do
  EXAMPLE_DATA = {
    "OrderNumber" => nil,
    "OrderGuid" => "ecf27dfa-3307-422b-a737-c7e3de46d9e9",
    "StoreId" => 1,
    "CustomerId" => 1,
    "BillingAddressId" => 11,
    "ShippingAddressId" => 12,
    "OrderStatusId" => 10,
    "ShippingStatusId" => 20,
    "PaymentStatusId" => 10,
    "PaymentMethodSystemName" => "Payments.Prepayment",
    "CustomerCurrencyCode" => "EUR",
    "CurrencyRate" => 1.0,
    "CustomerTaxDisplayTypeId" => 0,
    "VatNumber" => "",
    "OrderSubtotalInclTax" => 52.0,
    "OrderSubtotalExclTax" => 43.3333,
    "OrderSubTotalDiscountInclTax" => 0.0,
    "OrderSubTotalDiscountExclTax" => 0.0,
    "OrderShippingInclTax" => 0.0,
    "OrderShippingExclTax" => 0.0,
    "OrderShippingTaxRate" => 0.0,
    "PaymentMethodAdditionalFeeInclTax" => 0.0,
    "PaymentMethodAdditionalFeeExclTax" => 0.0,
    "PaymentMethodAdditionalFeeTaxRate" => 0.0,
    "TaxRates" => "20:8.666666666666666666666666666;   ",
    "OrderTax" => 8.6666,
    "OrderDiscount" => 0.0,
    "CreditBalance" => 0.0,
    "OrderTotalRounding" => 0.0,
    "OrderTotal" => 52.0,
    "RefundedAmount" => 0.0,
    "RewardPointsWereAdded" => false,
    "CheckoutAttributeDescription" => nil,
    "CheckoutAttributesXml" => nil,
    "CustomerLanguageId" => 1,
    "AffiliateId" => 0,
    "CustomerIp" => "37.24.104.252",
    "AllowStoringCreditCardNumber" => false,
    "CardType" => "",
    "CustomerOrderComment" => "",
    "AuthorizationTransactionId" => nil,
    "AuthorizationTransactionCode" => nil,
    "AuthorizationTransactionResult" => nil,
    "CaptureTransactionId" => nil,
    "CaptureTransactionResult" => nil,
    "SubscriptionTransactionId" => nil,
    "PurchaseOrderNumber" => nil,
    "PaidDateUtc" => nil,
    "ShippingMethod" => "Abholung",
    "ShippingRateComputationMethodSystemName" => "Shipping.FixedRate",
    "CreatedOnUtc" => "2017-03-20T11:07:08.947Z",
    "UpdatedOnUtc" => "2017-03-20T11:07:09.133Z",
    "RewardPointsRemaining" => nil,
    "HasNewPaymentNotification" => false,
    "AcceptThirdPartyEmailHandOver" => false,
    "OrderStatus" => "Pending",
    "PaymentStatus" => "Pending",
    "ShippingStatus" => "NotYetShipped",
    "CustomerTaxDisplayType" => "IncludingTax",
    "Id" => 4,
    "Customer" => {
      "CustomerGuid" => "3496e748-aef4-4118-9169-c4309f5821ec",
      "Username" => "info@smartstore.com",
      "Email" => "info@smartstore.com",
      "AdminComment" => nil,
      "IsTaxExempt" => false,
      "AffiliateId" => 0,
      "Active" => true,
      "IsSystemAccount" => false,
      "SystemName" => nil,
      "LastIpAddress" => "37.201.87.174",
      "CreatedOnUtc" => "2016-12-19T13:39:06.077Z",
      "LastLoginDateUtc" => "2021-01-26T11:53:16.033Z",
      "LastActivityDateUtc" => "2021-01-27T18:04:16.577Z",
      "Title" => nil,
      "FirstName" => "Max",
      "LastName" => "Mustermann",
      "FullName" => "Max Mustermann",
      "Company" => nil,
      "CustomerNumber" => nil,
      "BirthDate" => nil,
      "Gender" => nil,
      "VatNumberStatusId" => 0,
      "TimeZoneId" => nil,
      "TaxDisplayTypeId" => 0,
      "LastForumVisit" => nil,
      "LastUserAgent" =>
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36",
      "LastUserDeviceType" => nil,
      "Id" => 1
    },
    "BillingAddress" => {
      "Salutation" => nil,
      "Title" => nil,
      "FirstName" => "Max",
      "LastName" => "Mustermann",
      "Email" => "admin@meineshopurl.de",
      "Company" => "Max Mustermann",
      "CountryId" => 1,
      "StateProvinceId" => 1,
      "City" => "Musterstadt",
      "Address1" => "Musterweg 1",
      "Address2" => "",
      "ZipPostalCode" => "12345",
      "PhoneNumber" => "12345678",
      "FaxNumber" => "",
      "CreatedOnUtc" => "2016-12-19T13:39:06.137Z",
      "Id" => 11,
      "Country" => {
        "Name" => "Deutschland",
        "AllowsBilling" => true,
        "AllowsShipping" => true,
        "TwoLetterIsoCode" => "DE",
        "ThreeLetterIsoCode" => "DEU",
        "NumericIsoCode" => 276,
        "SubjectToVat" => true,
        "Published" => true,
        "DisplayOrder" => -10,
        "DisplayCookieManager" => false,
        "LimitedToStores" => false,
        "AddressFormat" =>
          "{{ Company }}\n" \
                      "{{ Salutation }} {{ Title }} {{ FirstName }} {{ LastName }}\n" \
                      "{{ Street1 }}\n" \
                      "{{ Street2 }}\n" \
                      "{{ ZipCode }} {{ City }}\n" \
                      "{{ Country | Upcase }}",
        "DefaultCurrencyId" => nil,
        "Id" => 1
      }
    },
    "ShippingAddress" => {
      "Salutation" => nil,
      "Title" => nil,
      "FirstName" => "Max",
      "LastName" => "Mustermann",
      "Email" => "admin@meineshopurl.de",
      "Company" => "Max Mustermann",
      "CountryId" => 1,
      "StateProvinceId" => 1,
      "City" => "Musterstadt",
      "Address1" => "Musterweg 1",
      "Address2" => "",
      "ZipPostalCode" => "12345",
      "PhoneNumber" => "12345678",
      "FaxNumber" => "",
      "CreatedOnUtc" => "2016-12-19T13:39:06.137Z",
      "Id" => 12,
      "Country" => {
        "Name" => "Deutschland",
        "AllowsBilling" => true,
        "AllowsShipping" => true,
        "TwoLetterIsoCode" => "DE",
        "ThreeLetterIsoCode" => "DEU",
        "NumericIsoCode" => 276,
        "SubjectToVat" => true,
        "Published" => true,
        "DisplayOrder" => -10,
        "DisplayCookieManager" => false,
        "LimitedToStores" => false,
        "AddressFormat" =>
          "{{ Company }}\n" \
                      "{{ Salutation }} {{ Title }} {{ FirstName }} {{ LastName }}\n" \
                      "{{ Street1 }}\n" \
                      "{{ Street2 }}\n" \
                      "{{ ZipCode }} {{ City }}\n" \
                      "{{ Country | Upcase }}",
        "DefaultCurrencyId" => nil,
        "Id" => 1
      }
    },
    "OrderItems" => [
      {
        "OrderItemGuid" => "f0640ceb-2716-4f0a-bfe6-3697966386bf",
        "OrderId" => 4,
        "ProductId" => 254,
        "Quantity" => 1,
        "UnitPriceInclTax" => 52.0,
        "UnitPriceExclTax" => 43.3333,
        "PriceInclTax" => 52.0,
        "PriceExclTax" => 43.3333,
        "TaxRate" => 20.0,
        "DiscountAmountInclTax" => 0.0,
        "DiscountAmountExclTax" => 0.0,
        "AttributeDescription" => "Farbe: Blau<br />Gr&#246;&#223;e: M",
        "AttributesXml" =>
          "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>",
        "DownloadCount" => 0,
        "IsDownloadActivated" => false,
        "LicenseDownloadId" => 0,
        "ItemWeight" => 0.5,
        "BundleData" => nil,
        "ProductCost" => 20.0,
        "DeliveryTimeId" => nil,
        "DisplayDeliveryTime" => false,
        "Id" => 5,
        "Product" => {
          "ProductTypeId" => 5,
          "ParentGroupedProductId" => 0,
          "Visibility" => "Full",
          "Condition" => "New",
          "Name" => "Ladies’ Sports Jacket",
          "ShortDescription" => "Sportliche Jacke für Freizeitaktivitäten",
          "FullDescription" =>
            "Oberstoff: 100% Polyamid\nFutterstoff: 65% Polyester, 35% Baumwolle\nFutterstoff 2: 100% Polyester\n\n" \
                        "Leichtes wind- und wasserabweisendes Gewebe, Futter aus weichem Single-Jersey\n" \
                        "Strickbündchen an Arm und Bund, 2 seitliche Taschen mit Reißverschluss, Kapuze\n" \
                        "in leicht tailliertem Schnitt",
          "AdminComment" => "-stm",
          "ProductTemplateId" => 3,
          "ShowOnHomePage" => true,
          "HomePageDisplayOrder" => 0,
          "MetaKeywords" => nil,
          "MetaDescription" => "Jacken",
          "MetaTitle" => nil,
          "AllowCustomerReviews" => true,
          "ApprovedRatingSum" => 0,
          "NotApprovedRatingSum" => 0,
          "ApprovedTotalReviews" => 0,
          "NotApprovedTotalReviews" => 0,
          "SubjectToAcl" => false,
          "LimitedToStores" => false,
          "Sku" => "112348",
          "ManufacturerPartNumber" => "JN1107",
          "Gtin" => nil,
          "IsGiftCard" => false,
          "GiftCardTypeId" => 0,
          "RequireOtherProducts" => false,
          "RequiredProductIds" => nil,
          "AutomaticallyAddRequiredProducts" => false,
          "IsDownload" => false,
          "UnlimitedDownloads" => true,
          "MaxNumberOfDownloads" => 10,
          "DownloadExpirationDays" => nil,
          "DownloadActivationTypeId" => 1,
          "HasSampleDownload" => false,
          "SampleDownloadId" => 13,
          "HasUserAgreement" => false,
          "UserAgreementText" => nil,
          "IsRecurring" => false,
          "RecurringCycleLength" => 100,
          "RecurringCyclePeriodId" => 0,
          "RecurringTotalCycles" => 10,
          "IsShipEnabled" => true,
          "IsFreeShipping" => false,
          "AdditionalShippingCharge" => 0.0,
          "IsTaxExempt" => false,
          "IsEsd" => false,
          "TaxCategoryId" => 1,
          "ManageInventoryMethodId" => 0,
          "StockQuantity" => 10000,
          "DisplayStockAvailability" => false,
          "DisplayStockQuantity" => false,
          "MinStockQuantity" => 0,
          "LowStockActivityId" => 0,
          "NotifyAdminForQuantityBelow" => 0,
          "BackorderModeId" => 0,
          "AllowBackInStockSubscriptions" => false,
          "OrderMinimumQuantity" => 1,
          "OrderMaximumQuantity" => 100,
          "QuantityStep" => 0,
          "QuantiyControlType" => "Spinner",
          "HideQuantityControl" => false,
          "AllowedQuantities" => nil,
          "DisableBuyButton" => false,
          "DisableWishlistButton" => false,
          "AvailableForPreOrder" => false,
          "CallForPrice" => false,
          "Price" => 55.0,
          "OldPrice" => 60.0,
          "ProductCost" => 20.0,
          "SpecialPrice" => 52.0,
          "SpecialPriceStartDateTimeUtc" => "2017-02-27T09:29:14Z",
          "SpecialPriceEndDateTimeUtc" => "2017-09-23T23:59:59Z",
          "CustomerEntersPrice" => false,
          "MinimumCustomerEnteredPrice" => 0.0,
          "MaximumCustomerEnteredPrice" => 1000.0,
          "HasTierPrices" => false,
          "LowestAttributeCombinationPrice" => nil,
          "AttributeChoiceBehaviour" => "GrayOutUnavailable",
          "HasDiscountsApplied" => false,
          "Weight" => 0.5,
          "Length" => 0.0,
          "Width" => 0.0,
          "Height" => 0.0,
          "AvailableStartDateTimeUtc" => nil,
          "AvailableEndDateTimeUtc" => nil,
          "DisplayOrder" => 0,
          "Published" => true,
          "IsSystemProduct" => false,
          "SystemName" => nil,
          "CreatedOnUtc" => "2017-03-20T10:14:38.35Z",
          "UpdatedOnUtc" => "2017-03-28T10:38:16.747Z",
          "DeliveryTimeId" => nil,
          "QuantityUnitId" => nil,
          "CustomsTariffNumber" => nil,
          "CountryOfOriginId" => 1,
          "BasePriceEnabled" => false,
          "BasePriceMeasureUnit" => "kg",
          "BasePriceAmount" => nil,
          "BasePriceBaseAmount" => nil,
          "BundleTitleText" => nil,
          "BundlePerItemShipping" => false,
          "BundlePerItemPricing" => false,
          "BundlePerItemShoppingCart" => false,
          "MainPictureId" => 2898,
          "HasPreviewPicture" => false,
          "ProductType" => "SimpleProduct",
          "BackorderMode" => "NoBackorders",
          "DownloadActivationType" => "WhenOrderIsPaid",
          "GiftCardType" => "Virtual",
          "LowStockActivity" => "Nothing",
          "ManageInventoryMethod" => "DontManageStock",
          "RecurringCyclePeriod" => "Days",
          "Id" => 254
        }
      }
    ]
  }

  before :each do
    OrderTransformer::DSL.define :smartstore, :v1 do
      require 'bigdecimal'
      require 'bigdecimal/util'

      order do
        customer do
          within "BillingAddress" do
            transform "Salutation", "Title", "FirstName", "LastName", to: "name", transformer: join(compact, with: " ")
            transform "FirstName", to: "firstname"
          end

          within "ShippingAddress" do
            transform "Salutation", "Title", "FirstName", "LastName", to: "shipping_name", transformer: join(compact, with: " ")
            transform "FirstName", to: "shipping_firstname"

            transform "ProductId", to: "product", transformer: ->(value) {
              fetch_from_api("....")
            }

            transform "THE THING", to: ["sku", "whatever"], transformer: -> (some_thing) { ".... do some thing expensive" }
          end
        end

        order_items do
          with_each "OrderItems" do
            transform "Quantity", to: "quantity", transformer: -> (val) { (val || "0").to_d }

            within "Product" do
              transform "SKU", to: "sku"
            end
          end
        end
      end
    end
  end

  after :each do
    OrderTransformer::DSL.remove(name: :smartstore, version: :v1)
  end

  it "does something useful" do
    expected_result = {
      "customer" => [{ "firstname" => ["Max"], "name" => "Max Mustermann" }, { "shipping_firstname" => ["Max"], "shipping_name" => "Max Mustermann" }],
      "order_items" => [[{ "quantity" => "1".to_d }]],
    }

    expect(OrderTransformer::DSL.get(name: :smartstore, version: :v1).execute(source_data: EXAMPLE_DATA)).to match(expected_result)
  end
end
