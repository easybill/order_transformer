require "json"

module OrderTransformerSpecTestTransformers
  def to_foo_bar(chain = nil)
    chain ||= __create_method_chain(caller(1, 1))
    chain.add ->(*args) { "#{args.first}-foo bar" }
  end
end

RSpec.describe OrderTransformer do
  let(:context) { double("Context", fetch_from_api: "I got it from the api") }
  let(:result_data) { ::OrderTransformer::DataNavigation::DataResultNavigator.new }

  context "when a single transformation is given" do
    subject { OrderTransformer::DSL.get(name: :smartstore, version: :v1) }
    let(:example_data) {
      {
        "OrderNumber" => "Order-123",
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
          "Salutation" => "Herr",
          "Title" => "Dr.",
          "FirstName" => "Max",
          "LastName" => "Mustermann",
          "Email" => "admin@meineshopurl.de",
          "Company" => "Max Mustermann GmbH",
          "CountryId" => 1,
          "StateProvinceId" => 1,
          "City" => "Musterstadt",
          "Address1" => "Musterweg 1",
          "Address2" => "oben links",
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
          "Salutation" => "Herr",
          "Title" => "Dr.",
          "FirstName" => "Max",
          "LastName" => "Mustermann",
          "Email" => "admin@meineshopurl.de",
          "Company" => "",
          "CountryId" => 1,
          "StateProvinceId" => 1,
          "City" => "Musterstadt",
          "Address1" => "Musterweg 1",
          "Address2" => "unten links",
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
          },
          {
            "OrderItemGuid" => "f0640ceb-2716-4f0a-bfe6-3697966386bf",
            "OrderId" => 4,
            "ProductId" => 254,
            "Quantity" => 1,
            "UnitPriceInclTax" => "45",
            "UnitPriceExclTax" => "45",
            "PriceInclTax" => "45",
            "PriceExclTax" => "45",
            "TaxRate" => "0",
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
              "ShortDescription" => "Sportliche Jacke",
              "FullDescription" =>
                "tailliertem Schnitt",
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
    }

    before :each do
      OrderTransformer::DSL.define :smartstore, :v1 do
        definition do
          include_transformers OrderTransformerSpecTestTransformers

          order as: :hash do
            transform "OrderNumber", to: "order_number", optional: false
            transform "CustomerCurrencyCode", to: "currency_code"
            transform "CreatedOnUtc", to: "purchase_date"
            transform "VatNumber", to: "vat_number"
            transform "PaymentMethodSystemName", to: "payment_type"
            transform "PaidDateUtc", to: "payment_date"
            transform "CustomerCurrencyCode", to: "currency"
            transform "OrderShippingInclTax", to: "shipping_gross"
            transform "OrderShippingExclTax", to: "shipping_net"
            transform "OrderShippingTaxRate", to: "shipping_tax_rate"
            transform "ShippingMethod", to: "shipping_method"
            transform "ShippingMethod", to: "with_foo_bar", transformer: to_foo_bar
          end

          customer as: :hash do
            within "Customer" do
              transform "Email", to: "email", optional: false
              transform "Email", to: "email_with_foo_bar", transformer: to_foo_bar
            end

            within "BillingAddress" do
              transform "Company", to: "name", transformer: join(strip)
              transform "FirstName", "Company", to: "firstname", transformer: ->(firstname, company) { (company || "").strip.size.zero? ? firstname : "" }
              transform "LastName", "Company", to: "lastname", transformer: ->(lastname, company) { (company || "").strip.size.zero? ? lastname : "" }
              transform "Address1", to: "address_1"
              transform "Address2", to: "address_2"
              transform "City", to: "city"
              transform "ZipPostalCode", to: "zipcode"
              transform "PhoneNumber", to: "phone_number"
              transform "FaxNumber", to: "fax_number"

              within "Country" do
                transform "Name", to: "country"
              end
            end

            within "ShippingAddress" do
              transform "Company", to: "shipping_name", transformer: join(strip)
              transform "FirstName", "Company", to: "shipping_firstname", transformer: ->(firstname, company) { (company || "").strip.size.zero? ? firstname : "" }
              transform "LastName", "Company", to: "shipping_lastname", transformer: ->(lastname, company) { (company || "").strip.size.zero? ? lastname : "" }
              transform "Address1", to: "shipping_address_1"
              transform "Address2", to: "shipping_address_2"
              transform "Address1", "Address2", to: ["shipping_address_2_a", "shipping_address_2_b"]
              transform "City", to: "shipping_city"
              transform "ZipPostalCode", to: "shipping_zipcode"

              within "Country" do
                transform "Name", to: "shipping_country"
              end
            end
          end

          order_items as: :array do
            with_each "OrderItems" do
              const to: "item_type", value: "item"
              transform "Quantity", to: "quantity", transformer: to_d
              transform "TaxRate", to: "vat_percent", transformer: to_d
              transform "UnitPriceInclTax", to: "unit_price_gross", transformer: to_d
              transform "UnitPriceExclTax", to: "unit_price_net", transformer: to_d
              transform "PriceInclTax", to: "total_price_gross", transformer: to_d
              transform "PriceExclTax", to: "total_price_net", transformer: to_d
              transform "DiscountAmountInclTax", to: "discount_gross", transformer: to_d
              transform "DiscountAmountExclTax", to: "discount_net", transformer: to_d

              transform "AttributesXml", to: "plain_text_attributes"
              transform "AttributesXml", to: "xml_text_attributes", sanitize: false

              transform "UnitPriceInclTax", "UnitPriceExclTax", to: "unit_price_vat", optional: false, transformer: ->(gross, net) {
                (gross || "0").to_d - (net || "0").to_d
              }

              transform "PriceInclTax", "PriceExclTax", to: "total_price_vat", transformer: ->(gross, net) {
                (gross || "0").to_d - (net || "0").to_d
              }

              transform "DiscountAmountInclTax", "DiscountAmountExclTax", to: "discount_vat", transformer: ->(gross, net) {
                (gross || "0").to_d - (net || "0").to_d
              }

              transform "ProductId", to: "product", transformer: ->(id) {
                context.fetch_from_api(id)
              }

              within "Product" do
                transform "ShortDescription", to: "title"
                transform "FullDescription", to: "title_2"
                transform "Sku", to: "sku"
                transform "Sku", to: "sku_with_foo_bar", transformer: to_foo_bar
              end
            end
          end
        end
      end
    end

    after :each do
      OrderTransformer::DSL.remove(name: :smartstore, version: :v1)
    end

    it "converts a complete structure" do
      expected_result = {
        "order" => {
          "order_number" => "Order-123",
          "currency_code" => "EUR",
          "purchase_date" => "2017-03-20T11:07:08.947Z",
          "vat_number" => "",
          "payment_type" => "Payments.Prepayment",
          "payment_date" => nil,
          "currency" => "EUR",
          "shipping_gross" => 0.0,
          "shipping_net" => 0.0,
          "shipping_tax_rate" => 0.0,
          "shipping_method" => "Abholung",
          "with_foo_bar" => "Abholung-foo bar"
        },
        "customer" => {
          "email" => "info@smartstore.com",
          "email_with_foo_bar" => "info@smartstore.com-foo bar",

          "name" => "Max Mustermann GmbH",
          "firstname" => "",
          "lastname" => "",
          "address_1" => "Musterweg 1",
          "address_2" => "oben links",

          "city" => "Musterstadt",
          "zipcode" => "12345",
          "country" => "Deutschland",

          "phone_number" => "12345678",
          "fax_number" => "",

          "shipping_name" => "",
          "shipping_firstname" => "Max",
          "shipping_lastname" => "Mustermann",
          "shipping_address_1" => "Musterweg 1",
          "shipping_address_2" => "unten links",
          "shipping_address_2_a" => "Musterweg 1",
          "shipping_address_2_b" => "unten links",

          "shipping_city" => "Musterstadt",
          "shipping_zipcode" => "12345",
          "shipping_country" => "Deutschland"
        },
        "order_items" => [
          {
            "item_type" => "item",
            "quantity" => "1".to_d,
            "vat_percent" => "20".to_d,
            "unit_price_gross" => 0.52e2,
            "unit_price_net" => 0.433333e2,
            "total_price_gross" => 0.52e2,
            "total_price_net" => 0.433333e2,
            "discount_gross" => 0.0,
            "discount_net" => 0.0,
            "unit_price_vat" => "8.6667".to_d,
            "total_price_vat" => "8.6667".to_d,
            "discount_vat" => 0.0,
            "product" => "I got it from the api",
            "title" => "Sportliche Jacke für Freizeitaktivitäten",
            "title_2" => "Oberstoff: 100% Polyamid\nFutterstoff: 65% Polyester, 35% Baumwolle\nFutterstoff 2: 100% Polyester\n\nLeichtes wind- und wasserabweisendes Gewebe, Futter aus weichem Single-Jersey\nStrickbündchen an Arm und Bund, 2 seitliche Taschen mit Reißverschluss, Kapuze\nin leicht tailliertem Schnitt",
            "sku" => "112348",
            "sku_with_foo_bar" => "112348-foo bar",
            "plain_text_attributes" => "47834785",
            "xml_text_attributes" => "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>"
          },
          {
            "item_type" => "item",
            "quantity" => 0.1e1,
            "vat_percent" => 0.0,
            "unit_price_gross" => 0.45e2,
            "unit_price_net" => 0.45e2,
            "total_price_gross" => 0.45e2,
            "total_price_net" => 0.45e2,
            "discount_gross" => 0.0,
            "discount_net" => 0.0,
            "unit_price_vat" => 0.0,
            "total_price_vat" => 0.0,
            "discount_vat" => 0.0,
            "product" => "I got it from the api",
            "title" => "Sportliche Jacke",
            "title_2" => "tailliertem Schnitt",
            "sku" => "112348",
            "sku_with_foo_bar" => "112348-foo bar",
            "plain_text_attributes" => "47834785",
            "xml_text_attributes" => "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>"
          }
        ]
      }

      result = subject.execute(source_data: example_data, context: context)

      expect(result).to eq(expected_result)
    end

    it "doesnt sanitize special chars" do
      example_data["BillingAddress"]["Company"] = "Mustermann GmbH & Co. KG"

      expected_result = {
        "order" => {
          "order_number" => "Order-123",
          "currency_code" => "EUR",
          "purchase_date" => "2017-03-20T11:07:08.947Z",
          "vat_number" => "",
          "payment_type" => "Payments.Prepayment",
          "payment_date" => nil,
          "currency" => "EUR",
          "shipping_gross" => 0.0,
          "shipping_net" => 0.0,
          "shipping_tax_rate" => 0.0,
          "shipping_method" => "Abholung",
          "with_foo_bar" => "Abholung-foo bar"
        },
        "customer" => {
          "email" => "info@smartstore.com",
          "email_with_foo_bar" => "info@smartstore.com-foo bar",

          "name" => "Mustermann GmbH & Co. KG",
          "firstname" => "",
          "lastname" => "",
          "address_1" => "Musterweg 1",
          "address_2" => "oben links",

          "city" => "Musterstadt",
          "zipcode" => "12345",
          "country" => "Deutschland",

          "phone_number" => "12345678",
          "fax_number" => "",

          "shipping_name" => "",
          "shipping_firstname" => "Max",
          "shipping_lastname" => "Mustermann",
          "shipping_address_1" => "Musterweg 1",
          "shipping_address_2" => "unten links",
          "shipping_address_2_a" => "Musterweg 1",
          "shipping_address_2_b" => "unten links",

          "shipping_city" => "Musterstadt",
          "shipping_zipcode" => "12345",
          "shipping_country" => "Deutschland"
        },
        "order_items" => [
          {
            "item_type" => "item",
            "quantity" => "1".to_d,
            "vat_percent" => "20".to_d,
            "unit_price_gross" => 0.52e2,
            "unit_price_net" => 0.433333e2,
            "total_price_gross" => 0.52e2,
            "total_price_net" => 0.433333e2,
            "discount_gross" => 0.0,
            "discount_net" => 0.0,
            "unit_price_vat" => "8.6667".to_d,
            "total_price_vat" => "8.6667".to_d,
            "discount_vat" => 0.0,
            "product" => "I got it from the api",
            "title" => "Sportliche Jacke für Freizeitaktivitäten",
            "title_2" => "Oberstoff: 100% Polyamid\nFutterstoff: 65% Polyester, 35% Baumwolle\nFutterstoff 2: 100% Polyester\n\nLeichtes wind- und wasserabweisendes Gewebe, Futter aus weichem Single-Jersey\nStrickbündchen an Arm und Bund, 2 seitliche Taschen mit Reißverschluss, Kapuze\nin leicht tailliertem Schnitt",
            "sku" => "112348",
            "sku_with_foo_bar" => "112348-foo bar",
            "plain_text_attributes" => "47834785",
            "xml_text_attributes" => "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>"
          },
          {
            "item_type" => "item",
            "quantity" => 0.1e1,
            "vat_percent" => 0.0,
            "unit_price_gross" => 0.45e2,
            "unit_price_net" => 0.45e2,
            "total_price_gross" => 0.45e2,
            "total_price_net" => 0.45e2,
            "discount_gross" => 0.0,
            "discount_net" => 0.0,
            "unit_price_vat" => 0.0,
            "total_price_vat" => 0.0,
            "discount_vat" => 0.0,
            "product" => "I got it from the api",
            "title" => "Sportliche Jacke",
            "title_2" => "tailliertem Schnitt",
            "sku" => "112348",
            "sku_with_foo_bar" => "112348-foo bar",
            "plain_text_attributes" => "47834785",
            "xml_text_attributes" => "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>"
          }
        ]
      }

      result = subject.execute(source_data: example_data, context: context)

      expect(result).to eq(expected_result)
    end

    context "when transformation has inheritance" do
      subject { OrderTransformer::DSL.get(name: :smartstore, version: :v2) }

      before :each do
        OrderTransformer::DSL.define :smartstore, :v2 do
          parent name: :smartstore, version: :v1
          definition do
            customer as: :hash do
              within "BillingAddress" do
                within "Country" do
                  transform "Name", to: "country", transformer: ->(desc) { "#{desc} --" }
                end
              end

              within "ShippingAddress" do
                within "Country" do
                  transform "Name", to: "shipping_country", transformer: ->(desc) { "#{desc} --" }
                end
              end
            end

            order_items as: :array do
              with_each "OrderItems" do
                within "Product" do
                  transform "ShortDescription", to: "title", transformer: ->(desc) { "#{desc} --" }
                  remove_entry "title_2"
                end
              end
            end
          end
        end
      end

      after :each do
        OrderTransformer::DSL.remove(name: :smartstore, version: :v2)
      end

      it "converts a complete structure" do
        expected_result = {
          "order" => {
            "order_number" => "Order-123",
            "currency_code" => "EUR",
            "purchase_date" => "2017-03-20T11:07:08.947Z",
            "vat_number" => "",
            "payment_type" => "Payments.Prepayment",
            "payment_date" => nil,
            "currency" => "EUR",
            "shipping_gross" => 0.0,
            "shipping_net" => 0.0,
            "shipping_tax_rate" => 0.0,
            "shipping_method" => "Abholung",
            "with_foo_bar" => "Abholung-foo bar"
          },
          "customer" => {
            "email" => "info@smartstore.com",
            "email_with_foo_bar" => "info@smartstore.com-foo bar",

            "name" => "Max Mustermann GmbH",
            "firstname" => "",
            "lastname" => "",
            "address_1" => "Musterweg 1",
            "address_2" => "oben links",

            "city" => "Musterstadt",
            "zipcode" => "12345",
            "country" => "Deutschland --",

            "phone_number" => "12345678",
            "fax_number" => "",

            "shipping_name" => "",
            "shipping_firstname" => "Max",
            "shipping_lastname" => "Mustermann",
            "shipping_address_1" => "Musterweg 1",
            "shipping_address_2" => "unten links",
            "shipping_address_2_a" => "Musterweg 1",
            "shipping_address_2_b" => "unten links",

            "shipping_city" => "Musterstadt",
            "shipping_zipcode" => "12345",
            "shipping_country" => "Deutschland --"
          },
          "order_items" => [
            {
              "item_type" => "item",
              "quantity" => "1".to_d,
              "vat_percent" => "20".to_d,
              "unit_price_gross" => 0.52e2,
              "unit_price_net" => 0.433333e2,
              "total_price_gross" => 0.52e2,
              "total_price_net" => 0.433333e2,
              "discount_gross" => 0.0,
              "discount_net" => 0.0,
              "unit_price_vat" => "8.6667".to_d,
              "total_price_vat" => "8.6667".to_d,
              "discount_vat" => 0.0,
              "product" => "I got it from the api",
              "title" => "Sportliche Jacke für Freizeitaktivitäten --",
              "sku" => "112348",
              "sku_with_foo_bar" => "112348-foo bar",
              "plain_text_attributes" => "47834785",
              "xml_text_attributes" => "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>"
            },
            {
              "item_type" => "item",
              "quantity" => 0.1e1,
              "vat_percent" => 0.0,
              "unit_price_gross" => 0.45e2,
              "unit_price_net" => 0.45e2,
              "total_price_gross" => 0.45e2,
              "total_price_net" => 0.45e2,
              "discount_gross" => 0.0,
              "discount_net" => 0.0,
              "unit_price_vat" => 0.0,
              "total_price_vat" => 0.0,
              "discount_vat" => 0.0,
              "product" => "I got it from the api",
              "title" => "Sportliche Jacke --",
              "sku" => "112348",
              "sku_with_foo_bar" => "112348-foo bar",
              "plain_text_attributes" => "47834785",
              "xml_text_attributes" => "<Attributes><ProductVariantAttribute ID=\"1227\"><ProductVariantAttributeValue><Value>4783</Value></ProductVariantAttributeValue></ProductVariantAttribute><ProductVariantAttribute ID=\"1228\"><ProductVariantAttributeValue><Value>4785</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>"
            }
          ]
        }

        result = subject.execute(source_data: example_data, context: context, result_data: result_data)

        expect(result).to eq(expected_result)
      end
    end
  end
end
