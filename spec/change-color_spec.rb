include RSpec
require_relative "../change-color.rb"

test_img = [
  [0,0,255],[0,0,0],[0,0,0],[0,0,0],
  [0,0,0],[0,0,255],[0,0,0],[0,0,0],
  [0,0,0],[0,0,255],[0,0,0],[0,0,0],
  [0,0,0],[0,0,0],[0,0,255],[0,0,0],
]

all_replaced = [
  [255,0,0],[0,0,0],[0,0,0],[0,0,0],
  [0,0,0],[255,0,0],[0,0,0],[0,0,0],
  [0,0,0],[255,0,0],[0,0,0],[0,0,0],
  [0,0,0],[0,0,0],[255,0,0],[0,0,0],
]

contiguous_replaced = [
  [0,0,255],[0,0,0],[0,0,0],[0,0,0],
  [0,0,0],[255,0,0],[0,0,0],[0,0,0],
  [0,0,0],[255,0,0],[0,0,0],[0,0,0],
  [0,0,0],[0,0,0],[0,0,255],[0,0,0],
]


describe Image do
  context "With a 4x4 image with blue dots and replace all with red" do
    it "Should return a image with red dots" do
      img = Image.new(4,4,test_img)
      img.change_color(1,1,[255,000,000])
      expect(img.datas).to eq all_replaced
    end
  end

  context "With a 4x4 image with blue dots and replace contiguous with red on pos 1,1" do
    it "Should return a image with two dots" do
      img = Image.new(4,4,test_img)
      img.change_adjacent(1,1,[255,000,000])
      expect(img.datas).to eq contiguous_replaced
    end
  end

  context "Changing 0,0 pixel color as zone change" do
    it "Should return an image with only this pixel changed and no error" do
      img = Image.new(4,4,test_img)
      img.change_adjacent(0,0, [255,0,0])
      expect(img.datas[0]).to eq [255,0,0]
      expect(img.datas[3]).to eq [0,0,0]
      expect(img.datas[5]).to eq [0,0,255]
    end
  end
end
