require "./spec_helper"

describe Intervalestimation do
    it "passes #1" do
      array = [0.1, 0.1, 0.2, -0.3, 0.1, 0.1, -0.3]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[0,2]]
    end
    it "passes #2" do
      array = [-0.1,0.1,0.2,-0.4,0.3,0.4,0.3,0.1]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[4,7]]
      array = [0.1,-0.1,0.2,-0.3,0.1,0.1,0.1,0.1]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[4,7],[0,2]]
      array = [0.1,0.1,0.2,-0.5,0.1,0.1,0.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[4,6],[0,2]]
      array = [0.1,0.1,0.2,-0.3,0.1,0.1,0.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[0,6]]
      array = [-0.5, 0.1, 0.1, 0.1, -0.5, -0.2, 0.2, 0.1, -0.3]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,3]]
    end
    it "passes #3" do
      array = [-0.2,0.1,0.1,0.1,-0.9,0.2,0.3,0.3,-0.9,0.2,0.3,0.4]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,3],[5,7],[9,11]].reverse
      array = [-0.2,0.1,0.1,0.1,-0.9,0.2,0.3,0.3,-1.0,0.2,0.3,0.2,-1.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,3],[5,7],[9,11]].reverse
      array = [-0.2,0.1,0.1,0.1,-0.2,0.2,0.3,0.3,-1.0,0.2,0.3,0.2,-1.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,7],[9,11]].reverse
      array = [-0.2,0.1,0.1,0.1,-0.2,0.2,0.3,0.3,-1.0,0.3,0.2,-1.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,7]]
      array = [-0.2,0.1,0.1,0.1,-0.2,0.1,0.1,-1.0,0.3,0.2,-1.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,6]]
      array = [-0.2,0.1,0.1,0.1,-0.3,0.1,0.1,-1.0,0.3,0.2,-1.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,3]]
      array = [-0.2,0.1,0.1,0.9,-0.3,0.1,0.5,-1.0,0.3,0.2,-1.2]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[1,6]]
    end
    it "passes #4" do
      array = [-0.2,0.1,-0.2,0.2,-0.3,0.1,-0.3]
      Intervalestimation::Sequence.intervaldefinete(array, 1).should eq [] of Int32
      array = [-0.2,0.1,0.1,-0.3,0.1,0.1,0.5]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[4,6]]
      array = [0.2,0.1,0.1,-0.3,0.1,0.1,0.5]
      Intervalestimation::Sequence.intervaldefinete(array, 2).should eq [[0,6]]
      array = [-0.2,0.1,-0.2,0.1,-0.2,0.1,-0.3]
      Intervalestimation::Sequence.intervaldefinete(array, 0).should eq [[1,1],[3,3],[5,5]].reverse
      array = [-0.2,0.1,-0.2,0.2,-0.2,0.1,-0.3]
      Intervalestimation::Sequence.intervaldefinete(array, 0).should eq [[1,1],[3,3],[5,5]].reverse
      array = [-0.2,0.1,0.1,-0.3,0.1,0.1,0.5]
      Intervalestimation::Sequence.intervaldefinete(array, 0).should eq [[1,2],[4,6]].reverse
    end
    it "passes #5" do
      array = [-0.2,0.1,0.1,0.9,-0.3,0.1,0.5,-1.0,0.3,0.2,-1.2]
      6.times do |i|
        Intervalestimation::Sequence.intervaldefinete(array, i).map{|t| t[1] - t[0]}.min.should be >= i
      end
		end
end
