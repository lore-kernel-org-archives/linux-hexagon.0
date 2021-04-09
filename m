From: Christophe Leroy <christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
Subject: Re: [PATCH v4 18/20] x86: Convert to GENERIC_CMDLINE
Date: Fri, 9 Apr 2021 12:20:49 +0200
Message-ID: <834c4850-5541-b5c2-0b7b-d7d960ab2629@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <ab0fd4477964cdbf99e3dd2965a455aa3e738e4b.1617375802.git.christophe.leroy@csgroup.eu>
 <20210408194148.GB1724284@robh.at.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20210408194148.GB1724284-OqLlcNKxUisOASNP4CLbKB2eb7JE58TQ@public.gmane.org>
Content-Language: fr
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, danielwa-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, daniel-R/FLGEdV95bo9U+Z1CfBt0SU0eOFXohjCypLqA8HKkk@public.gmane.org, arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, microblaze <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2 <ley.foon.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org



Le 08/04/2021 à 21:41, Rob Herring a écrit :
> On Fri, Apr 02, 2021 at 03:18:20PM +0000, Christophe Leroy wrote:
>> This converts the architecture to GENERIC_CMDLINE.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
>> ---
>>   arch/x86/Kconfig        | 45 ++---------------------------------------
>>   arch/x86/kernel/setup.c | 17 ++--------------
>>   2 files changed, 4 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a20684d56b4b..66b384228ca3 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -104,6 +104,7 @@ config X86
>>   	select ARCH_USE_QUEUED_SPINLOCKS
>>   	select ARCH_USE_SYM_ANNOTATIONS
>>   	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>> +	select ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT
> 
> Seems to be non-existent kconfig option.

Oops. Added in v5.

>> @@ -883,18 +881,7 @@ void __init setup_arch(char **cmdline_p)
>>   	bss_resource.start = __pa_symbol(__bss_start);
>>   	bss_resource.end = __pa_symbol(__bss_stop)-1;
>>   
>> -#ifdef CONFIG_CMDLINE_BOOL
>> -#ifdef CONFIG_CMDLINE_FORCE
>> -	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -#else
>> -	if (builtin_cmdline[0]) {
>> -		/* append boot loader cmdline to builtin */
>> -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
>> -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>> -		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -	}
>> -#endif
>> -#endif
>> +	cmdline_build(boot_command_line, boot_command_line);
>>   
>>   	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>>   	*cmdline_p = command_line;
> 
> Once this is all done, I wonder if we can get rid of the strlcpy and
> perhaps also cmdline_p.
> 

It seems rather complicated, in init/main.c you have heavy manipulations of command lines which 
seems to be done in setup_command_line() which seems to add stuff in front of command lines, at the 
end we end up with several command lines:

/* Untouched saved command line (eg. for /proc) */
char *saved_command_line;
/* Command line for parameter parsing */
static char *static_command_line;
/* Untouched extra command line */
static char *extra_command_line;

Some of them come from the cmdline_p which others are from boot_command_line.

I think a cleanup on all that stuff would be worth it as a further step.
