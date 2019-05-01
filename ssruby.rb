#!/usr/bin/ruby
require 'socket'                 

server = TCPServer.open(2000)
loop {
   Thread.start(server.accept) do |client|
    a=client.recvfrom(1024)[0].chomp;
    puts a;

    def checks(var)
        sum=0;
        var.each_byte do |c|
            sum= sum + c;
        end
       return sum;
    end
    if a[0]=='R'
        iL=Array.new(4);
        a=0;
        t=a[0];
        on=a[1...9];
        sn=a[9...17];
        cs=a[17,21];
        tmp=t+on+sn;
        k=checks tmp;
        puts sn
        if k.to_s==cs
            puts "Success";
            File.open("log.txt","a") do |line|
                line.puts on+","+sn;
            end
            File.open("data.txt").each do |line|
                tline=line.split(",");
                if tline[0]==sn
                    iL[0]=tline[0];
                    iL[1]=tline[1];
                    iL[2]=tline[2];
                    iL[3]=tline[3];
                    a=1;
                end
            end
            if a==1
                client.puts iL;
            else
                client.puts "Error!!! Not found.";
            end
            puts a;
        end
    end
    if a[0]=='U'
        t=a[0];
        sn=a[1...9];
        data=a[9...17];
        time=a[17...23];
        date=a[23...31];
        cs=a[31...35];
        tmp=t+sn+data+time+date;
        k=checks tmp;
        if k.to_s==cs
            puts "Success";
            File.open("data.txt","a") do |line|
                line.puts sn+","+data+","+time+","+date;
            end
        end
    end

   client.close
   end
}
