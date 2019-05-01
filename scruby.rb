#!/usr/bin/ruby
require 'socket' 

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

def check(var, type, num)
    until var.length<=num
        if var.length>num
            puts "The maximum of letters is #{num}";
            puts "Insert another #{type} ";
            var=gets.chomp;
        end
    end
    if var.length<num
        for i in 1..num-var.length
            var=var+" ";
        end
    end
    return var;
end

def checks(var)
    sum=0;
    var.each_byte do |c|
        sum= sum + c;
    end
   return sum;
end
a='No';
until a.length()==1 && a=='R'||a=='U' || a=='r'||a=='u' do
puts "Are you a observer=[R] or a sensor=[U]? ";
a=gets.chomp;
if a.length!=1
    puts "Insert just a letter";
end

if a=='R' || a=='r'
    puts "What is the name of the observer: ";
    oinput=gets.chomp;
    oname=check oinput, "observer name", 8;
    puts "What is the name of the sensor: ";
    sinput=gets.chomp;
    sname= check sinput, "sensor's name ", 8;
    temporal='R'+oname+sname;
    csum=checks temporal;
    rmsg=temporal+csum.to_s;
    puts "\n";
    s.send rmsg,0;
end

if a=='U' ||a=='u'
    puts "Insert sensor's name: ";
    sinput=gets.chomp;
    sname=check sinput, "Sensor's name", 8;
    puts "Insert sensor's Data: ";
    dinput=gets.chomp;
    dsensor=check dinput, "Sensor's data", 8;
    puts "Insert the Time [HHMMSS]: ";
    tinput=gets.chomp;
    time=check tinput, "Time", 6;
    puts "Insert Date [MMDDYYYY]: ";
    dainput=gets.chomp;
    date=check dainput, "Date", 8;
    temporal2='U'+sname+dsensor+time+date;
    csum2=checks temporal2;
    umsg=temporal2+csum2.to_s;
    puts "\n";
    s.send umsg,0;
end
mline=Array.new(4);
b=0;
while line = s.gets
    mline[b]=line.chop;
    b=b+1;
end
   if mline[0].start_with? 'S'
    puts mline[0];
   else
    puts "Request: ";
    puts "Name: #{mline[0]}";
    puts "Data: #{mline[1]}";
    puts "Time [HHMMSS]: #{mline[2]}";
    puts "Date [MMDDYYYY]: #{mline[3]}";
   end
end
s.close
