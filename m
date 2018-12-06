From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Date: Thu, 6 Dec 2018 21:14:04 +0100
Message-ID: <77351ea7-e153-d293-1016-2dd45cf96fee@c-s.fr>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jason Wessel <jason.wessel@windriv>



Le 06/12/2018 à 15:09, Daniel Thompson a écrit :
> On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
>> MIPS is the only architecture modifying arch_kgdb_ops during init.
>> This patch makes the init static, so that it can be changed to
>> const in following patch, as recommended by checkpatch.pl
>>
>> Suggested-by: Paul Burton <paul.burton@mips.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
>  From my side this is
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Since this is a dependency for the next patch I'd be happy to take via
> my tree... but would need an ack from the MIPS guys to do that.

Got an ack from MIPS:
Acked-by: Paul Burton <paul.burton@mips.com>

Included in commit text v2

Christophe

> 
> 
> Daniel.
> 
>> ---
>>   arch/mips/kernel/kgdb.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
>> index eb6c0d582626..31eff1bec577 100644
>> --- a/arch/mips/kernel/kgdb.c
>> +++ b/arch/mips/kernel/kgdb.c
>> @@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>>   	return -1;
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops;
>> +struct kgdb_arch arch_kgdb_ops = {
>> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> +	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
>> +#else
>> +	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
>> +#endif
>> +};
>>   
>>   int kgdb_arch_init(void)
>>   {
>> -	union mips_instruction insn = {
>> -		.r_format = {
>> -			.opcode = spec_op,
>> -			.func	= break_op,
>> -		}
>> -	};
>> -	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
>> -
>>   	register_die_notifier(&kgdb_notifier);
>>   
>>   	return 0;
>> -- 
>> 2.13.3
>>
