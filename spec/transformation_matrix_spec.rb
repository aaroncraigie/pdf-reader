# coding: utf-8

require File.dirname(__FILE__) + "/spec_helper"

# The results in these specs were generated at
# http://www.calcul.com/matrix-multiply-3x3-3x3 to ensure correctness.

describe PDF::Reader::TransformationMatrix, "#multiply_with_an_object!" do
  class PDF::Reader::TransformationMatrix
    # a helper method for tests
    def multiply_with_an_object!(m2)
      multiply!(
        m2.a, m2.b,
        m2.c, m2.d,
        m2.e, m2.f
      )
    end
  end
  context "with [2,3,0   4,5,0   6 7 1]" do
    let(:matrix_one) { PDF::Reader::TransformationMatrix.new(2,3,4,5,6,7)}

    context "and the identity matrix" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(1,0,0,1,0,0)}

      it "should leave the values unchanged" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [2,3,0,  4,5,0,  6,7,1]
      end

      it "should leave the values unchanged when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [2,3,0,  4,5,0,  6,7,1]
      end
    end

    context "and a horizontal displacement" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(1,0, 0,1, 10,0)}

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [2,3,0,  4,5,0,  16,7,1]
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [2,3,0,  4,5,0,  26,37,1]
      end
    end

    context "and applying a vertical displacement" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(1,0, 0,1, 0,10)}

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [2,3,0,  4,5,0,  6,17,1]
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [2,3,0,  4,5,0,  46,57,1]
      end
    end

    context "and applying a horizontal and vertical displacement" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(1,0, 0,1, 10,10)}

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [2,3,0,  4,5,0,  16,17,1]
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [2,3,0,  4,5,0,  66,87,1]
      end
    end

    context "and applying a horizontal scale" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(10,0, 0,1, 0,0)}

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [20,3,0,  40,5,0,  60,7,1]
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [20,30,0,  4,5,0,  6,7,1]
      end
    end

    context "and applying a vertical scale" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(1,0, 0,10, 0,0)}

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [2,30,0,  4,50,0,  6,70,1]
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [2,3,0,  40,50,0,  6,7,1]
      end
    end

    context "and applying a horizontal and vertical scale" do
      let(:matrix_two) { PDF::Reader::TransformationMatrix.new(10,0, 0,10, 0,0)}

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        matrix_one.to_a.should == [20,30,0,  40,50,0,  60,70,1]
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        matrix_two.to_a.should == [20,30,0,  40,50,0,  6,7,1]
      end
    end

    context "and applying a 30 degree rotation" do
      let(:matrix_two) {
        PDF::Reader::TransformationMatrix.new(
          Math.cos(30),   Math.sin(30),
          -1*Math.sin(30),Math.cos(30),
          0,              0
        )
      }

      it "should set the new matrix values" do
        matrix_one.multiply_with_an_object!(matrix_two)

        # we can't use #to_a in this test because of all the floating point nums
        matrix_one.a.round(3).should ==  3.273
        matrix_one.b.round(3).should == -1.513
        matrix_one.c.round(3).should ==  5.557
        matrix_one.d.round(3).should == -3.181
        matrix_one.e.round(3).should ==  7.842
        matrix_one.f.round(3).should == -4.848
      end

      it "should set the new matrix values when reversed" do
        matrix_two.multiply_with_an_object!(matrix_one)

        # we can't use #to_a in this test because of all the floating point nums
        matrix_two.a.round(3).should == -3.644
        matrix_two.b.round(3).should == -4.477
        matrix_two.c.round(3).should ==  2.593
        matrix_two.d.round(3).should ==  3.735
        matrix_two.e.round(3).should ==  6
        matrix_two.f.round(3).should ==  7
      end
    end
  end

end
