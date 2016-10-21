From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH] Hexagon-setup: Combine four seq_printf() calls into one
 call in show_cpuinfo()
Date: Fri, 21 Oct 2016 11:00:22 +0200
Message-ID: <e9daa136-c6ab-2f96-3d20-6e143fa1170b@users.sourceforge.net>
References: <c19c69d5-600c-f08b-f448-0420e677db63@users.sourceforge.net>
 <alpine.DEB.2.10.1610210918420.3212@hadrien>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1610210918420.3212@hadrien>
Sender: kernel-janitors-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

>> +++ b/arch/hexagon/kernel/setup.c
>> @@ -132,13 +132,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>  	if (!cpu_online(cpu))
>>  		return 0;
>>  #endif
>> -
>> -	seq_printf(m, "processor\t: %d\n", cpu);
>> -	seq_printf(m, "model name\t: Hexagon Virtual Machine\n");
>> -	seq_printf(m, "BogoMips\t: %lu.%02lu\n",
>> -		(loops_per_jiffy * HZ) / 500000,
>> -		((loops_per_jiffy * HZ) / 5000) % 100);
>> -	seq_printf(m, "\n");
>> +	seq_printf(m,
>> +		   "processor\t: %d\n"
>> +		   "model name\t: Hexagon Virtual Machine\n"
>> +		   "BogoMips\t: %lu.%02lu\n"
>> +		   "\n",
>> +		   cpu,
>> +		   (loops_per_jiffy * HZ) / 500000,
>> +		   ((loops_per_jiffy * HZ) / 5000) % 100);
> 
> This looks completely pointless.

Thanks for your software development opinion in this use case.


> It is harder to see how the arguments fit into the strings
> and it is harder to see where the strings end and the arguments begin.

Is it really so difficult to interpret the suggested construction
of a single (and relatively small) format string?

Regards,
Markus
