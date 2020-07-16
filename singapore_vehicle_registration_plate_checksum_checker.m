clc; clear;

% Enter vehicle registration plate here
number_plate = 'sjz6107';




% DO NOT EDIT
suffix_array = 'AZYXUTSRPMLKJHGEDCB';
multiplier = [9 4 5 4 3 2];
prefix_flag = 0;

number_plate = upper(number_plate);

B = isstrprop(number_plate, 'alpha');

fprintf('\n\n');

if B(end)
    suffix_entered = number_plate(end);
    fprintf('Entered suffix: %c\n', suffix_entered);
    B(end) = 0;
    prefix_flag = 1;
else
    fprintf('Suffix was not entered. Proceeding to calculate suffix..\n');
end

prefix = number_plate(B);
prefix_count = sum(B);

B = isstrprop(number_plate, 'digit');

digits = number_plate(B);
digits_count = sum(B);

switch prefix_count
    case 1
        sum1 = 0;
        sum2 = (prefix(1) - 64) * multiplier(2);
    case 2
        sum1 = (prefix(1) - 64) * multiplier(1);
        sum2 = (prefix(2) - 64) * multiplier(2);
    case 3
        sum1 = (prefix(2) - 64) * multiplier(1);
        sum2 = (prefix(3) - 64) * multiplier(2);
    otherwise
        disp('Suffix entry is wrong.\n\n')
        return;
end

switch digits_count
    case 1
        sum6 = (digits(1) - 48) * multiplier(6);
        sum5 = 0;
        sum4 = 0;
        sum3 = 0;
    case 2
        sum6 = (digits(2) - 48) * multiplier(6);
        sum5 = (digits(1) - 48) * multiplier(5);
        sum4 = 0;
        sum3 = 0;
    case 3
        sum6 = (digits(3) - 48) * multiplier(6);
        sum5 = (digits(2) - 48) * multiplier(5);
        sum4 = (digits(1) - 48) * multiplier(4);
        sum3 = 0;
    case 4
        sum6 = (digits(4) - 48) * multiplier(6);
        sum5 = (digits(3) - 48) * multiplier(5);
        sum4 = (digits(2) - 48) * multiplier(4);
        sum3 = (digits(1) - 48) * multiplier(3);
    otherwise
        disp('Digits entry is wrong.\n\n')
        return;
end

sum_total = sum1 + sum2 + sum3 + sum4 + sum5 + sum6;
index = mod(sum_total, 19) + 1;

if prefix_flag
    if strcmpi(suffix_array(index), suffix_entered)
        fprintf('Entered suffix is correct. \n');
        fprintf('Plate is %s.', number_plate);
        return;
    else
        fprintf('Entered suffix is wrong. ');
        fprintf('Suffix is %c.\n', suffix_array(index));
        fprintf('Plate is %s%c.', number_plate(1:end-1), suffix_array(index));
    end
else
    fprintf('Suffix is %c.\n', suffix_array(index));
    fprintf('Plate is %s%c.', number_plate(1:end), suffix_array(index));
end

fprintf('\n\n');
