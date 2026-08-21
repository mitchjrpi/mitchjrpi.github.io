subject to tri123: x[1,2] + x[2,3] - x[1,3] <= 1;

subject to tri126: x[1,2] + x[2,6] - x[1,6] <= 1;

subject to tri145: x[1,4] + x[4,5] - x[1,5] <= 1;

subject to tri235: x[2,3] + x[3,5] - x[2,5] <= 1;

subject to tri238: x[2,3] + x[3,8] - x[2,8] <= 1;

subject to tri134n: -x[1,3] - x[3,4] + x[1,4] <= 0;

subject to tri246n: -x[2,4] - x[4,6] + x[2,6] <= 0;

subject to tri247n: -x[2,4] - x[4,7] + x[2,7] <= 0;

subject to tri468n: -x[4,6] - x[6,8] + x[4,8] <= 0;

subject to tri478n: -x[4,7] - x[7,8] + x[4,8] <= 0;

subject to tri568n: -x[5,6] - x[6,8] + x[5,8] <= 0;
