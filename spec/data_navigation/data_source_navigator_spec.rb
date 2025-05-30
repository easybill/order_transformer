require "spec_helper"
require "json"

module OrderTransformer
  module DataNavigation
    RSpec.describe DataSourceNavigator do
      let(:test_source) {
        {
          "level_1_a" => {
            "level_2_a" => [
              {
                "level_3_[0]_a" => "hello",
                "level_3_[0]_b" => "world"
              },
              {
                "level_3_[1]_a" => "hello",
                "level_3_[1]_b" => "world"
              }
            ],
            "level_2_b" => "new string 2 b",
            "level_2_c" => [
              {
                "level_3_a" => [
                  {
                    "level_4_[0]_a" => [
                      {
                        "level_5_a" => "level 5 a"
                      },
                      {
                        "level_5_b" => "level 5 b"
                      }
                    ]
                  },
                  {
                    "level_4_[1]_a" => [
                      {
                        "level_5_c" => "level 5 c"
                      },
                      {
                        "level_5_d" => "level 5 d"
                      }
                    ]
                  }
                ]
              },
              {
                "level_3_a" => [
                  {
                    "level_4_[0]_a" => [
                      {
                        "level_5_a" => "level 5 k"
                      },
                      {
                        "level_5_b" => "level 5 l"
                      }
                    ]
                  },
                  {
                    "level_4_[1]_a" => [
                      {
                        "level_5_c" => "level 5 m"
                      },
                      {
                        "level_5_d" => "level 5 n"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        }
      }
      let(:navigator) { DataSourceNavigator.new source: test_source }

      it "can access top level elements" do
        expect(navigator.get).to match(test_source)
      end

      it "can access first subelements elements" do
        navigator.within "level_1_a", false do
          expect(navigator.get).to match(test_source["level_1_a"])
        end
      end

      it "can access top level elements after accessing subelements" do
        navigator.within "level_1_a", false do
          expect(navigator.get).to match(test_source["level_1_a"])
        end

        expect(navigator.get).to match(test_source)
      end

      it 'returns "true" when a key exists' do
        navigator.within "level_1_a", false do
          expect(navigator.key?("level_2_a")).to be_truthy
        end
      end

      it 'returns "false" when a key does not exists' do
        navigator.within "level_1_a", false do
          expect(navigator.key?("levelx_2_a")).to be_falsey
        end
      end

      it "returns the value for a given key" do
        navigator.within "level_1_a", false do
          expect(navigator.fetch("level_2_a")).to match(test_source["level_1_a"]["level_2_a"])
        end
      end

      it "raises a 'KeyError', when a sub key can't be fetched" do
        navigator.within "level_1_a", false do
          expect { navigator.fetch("level_2_ax") }.to raise_error(OrderTransformer::KeyError)
        end
      end

      context "key is not optional" do
        let(:optional) { false }

        it "raises a 'KeyError', when a key in the top level does not exists" do
          expect {
            navigator.within "level_1_a_23", optional do
            end
          }.to raise_error(OrderTransformer::KeyError)
        end

        it "raises a 'StructureMissMatchError', when a key in the top level has a nil value" do
          test_source["level_1_a_23"] = nil
          expect {
            navigator.within "level_1_a_23", optional do
            end
          }.to raise_error(OrderTransformer::StructureMissMatchError)
        end
      end

      context "key is optional" do
        let(:optional) { true }

        it "does not raise a 'KeyError', when a key in the top level does not exists" do
          expect {
            navigator.within "level_1_a_23", optional do
            end
          }.not_to raise_error
        end

        it "raises a 'StructureMissMatchError', when a key in the top level has a nil value" do
          test_source["level_1_a_23"] = nil
          expect {
            navigator.within "level_1_a_23", optional do
            end
          }.not_to raise_error
        end
      end

      it "traverses an array with an index" do
        expected_resul = test_source["level_1_a"]["level_2_a"].each_with_index.map { |val, index| {index: index, value: val} }
        tmp_result = []
        navigator.within "level_1_a", false do
          navigator.within "level_2_a", false do
            navigator.each_with_index do |nav, index|
              tmp_result.push({index: index, value: nav.get})
            end
          end
        end

        expect(tmp_result).to match(expected_resul)
      end

      it "traverses complex structures" do
        expected_result = [
          {
            index: 0,
            index2: 0,
            value: {
              "level_4_[0]_a" => [
                {"level_5_a" => "level 5 a"},
                {"level_5_b" => "level 5 b"}
              ]
            }
          },
          {
            index: 0,
            index2: 1,
            value: {
              "level_4_[1]_a" => [
                {"level_5_c" => "level 5 c"},
                {"level_5_d" => "level 5 d"}
              ]
            }
          },
          {
            index: 1,
            index2: 0,
            value: {
              "level_4_[0]_a" => [
                {
                  "level_5_a" => "level 5 k"
                },
                {
                  "level_5_b" => "level 5 l"
                }
              ]
            }
          },
          {
            index: 1,
            index2: 1,
            value: {
              "level_4_[1]_a" => [
                {
                  "level_5_c" => "level 5 m"
                },
                {
                  "level_5_d" => "level 5 n"
                }
              ]
            }
          }

        ]
        tmp_result = []

        navigator.within "level_1_a", false do
          navigator.within "level_2_c", false do
            navigator.each_with_index do |nav, index|
              nav.within "level_3_a", false do
                nav.each_with_index do |nav2, index2|
                  tmp_result.push({index: index, index2: index2, value: nav2.get})
                end
              end
            end
          end
        end

        expect(tmp_result).to match(expected_result)
      end
    end
  end
end
