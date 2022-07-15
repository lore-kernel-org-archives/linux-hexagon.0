From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 6/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Date: Fri, 15 Jul 2022 06:49:46 -0700
Message-ID: <8c949bd4-d25a-d5f5-49be-59d52e4b6c9d@roeck-us.net>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220624121313.2382500-7-alexandr.lobakin@intel.com>
 <20220715000402.GA512558@roeck-us.net>
 <20220715132633.61480-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rs46+iydynCKHLHZ1GP3rF0W0E38SP1veulXa6gwRZ4=;
        b=U2LPKLM/AjT1a2LjEeJbIoC7cMGOq1yROmt0cZz2Ais3HJJbyhb17PcE+5FV+ybUP8
         +DSpyzNvjpXy8F2wrmZ0lTlqucMS7kjrw4Q9h/Tne1y2K9xW3tm2zMzEVInk6+Y2kNSK
         xK5+NjqnN7jZRM20X7NKghDHD1GEMUwYqciGlk2cObJdUKWdRpmYfuyS/zSPa7rtAs0J
         /eL2zWxi2I+kPcM56S+S1qVAVJaJURtunnq0/WI/1FWTaavZX0kfTCaS9YaUXyinPP0X
         /r6r+fcRBASD1bIPLyE3iFMUJV6F7KavxvqQHCWQ7TydHLHLIKdC54p0qZnsEtBjn01F
         8XWg==
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Language: en-US
In-Reply-To: <20220715132633.61480-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick

On 7/15/22 06:26, Alexander Lobakin wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Thu, 14 Jul 2022 17:04:02 -0700
> 
>> On Fri, Jun 24, 2022 at 02:13:10PM +0200, Alexander Lobakin wrote:
>>> Currently, many architecture-specific non-atomic bitop
>>> implementations use inline asm or other hacks which are faster or
> 
> [...]
> 
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>> Reviewed-by: Marco Elver <elver@google.com>
>>
>> Building i386:allyesconfig ... failed
>> --------------
>> Error log:
>> arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'send_ebook_state':
>> arch/x86/platform/olpc/olpc-xo1-sci.c:83:63: error: logical not is only applied to the left hand side of comparison
> 
> Looks like a trigger, not a cause... Anyway, this construct:
> 
> 	unsigned char state;
> 
> 	[...]
> 
> 	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
> 
> doesn't look legit enough.
> That redundant double-negation [of boolean value], together with
> comparing boolean to char, provokes compilers to think the author
> made logical mistakes here, although it works as expected.
> Could you please try (if it's not automated build which you can't
> modify) the following:
> 

Agreed, the existing code seems wrong. The change below looks correct
and fixes the problem. Feel free to add

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

to the real patch.

Thanks,
Guenter

> --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> @@ -80,7 +80,7 @@ static void send_ebook_state(void)
>   		return;
>   	}
>   
> -	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
> +	if (test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == !!state)
>   		return; /* Nothing new to report. */
>   
>   	input_report_switch(ebook_switch_idev, SW_TABLET_MODE, state);
> ---
> 
> We'd take it into the bitmap tree then. The series revealed
> a fistful of existing code issues already :)
> 
>>
>> Bisect log attached.
>>
>> Guenter
>>
>> ---
>> # bad: [4662b7adea50bb62e993a67f611f3be625d3df0d] Add linux-next specific files for 20220713
>> # good: [32346491ddf24599decca06190ebca03ff9de7f8] Linux 5.19-rc6
>> git bisect start 'HEAD' 'v5.19-rc6'
>> # good: [8b7e002d8bc6e17c94092d25e7261db4e6e5f2cc] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
>> git bisect good 8b7e002d8bc6e17c94092d25e7261db4e6e5f2cc
>> # good: [07f6d21d6e33c1e28e24ae84e9d26e4e7d4853f5] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>> git bisect good 07f6d21d6e33c1e28e24ae84e9d26e4e7d4853f5
>> # good: [5ff085e5d4f6700e03635d5e700f52163a6dc2a7] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>> git bisect good 5ff085e5d4f6700e03635d5e700f52163a6dc2a7
>> # good: [eb9e3fdbdd8b61ef0f4bee23259fe6ab69e463ab] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
>> git bisect good eb9e3fdbdd8b61ef0f4bee23259fe6ab69e463ab
>> # good: [9f2183cd961e5ddb7954eafb6bb01a495c6a9c7b] hexagon/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
>> git bisect good 9f2183cd961e5ddb7954eafb6bb01a495c6a9c7b
>> # bad: [e878aa5faf9ac8c0b5d0c3f293389c194c250fff] Merge branch 'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect bad e878aa5faf9ac8c0b5d0c3f293389c194c250fff
>> # good: [cf95d50205f62c4f5f538676def847292cf39fa9] fs: don't call ->writepage from __mpage_writepage
>> git bisect good cf95d50205f62c4f5f538676def847292cf39fa9
>> # good: [5103cbfd92d3587713476f94f9485b96e02f0146] Merge branch 'for-next/execve' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
>> git bisect good 5103cbfd92d3587713476f94f9485b96e02f0146
>> # good: [ee56c3e8eec166f4e4a2ca842b7804d14f3a0208] Merge branch 'master' into mm-nonmm-stable
>> git bisect good ee56c3e8eec166f4e4a2ca842b7804d14f3a0208
>> # bad: [dc34d5036692c614eef23c1130ee42a201c316bf] lib: test_bitmap: add compile-time optimization/evaluations assertions
>> git bisect bad dc34d5036692c614eef23c1130ee42a201c316bf
>> # good: [bb7379bfa680bd48b468e856475778db2ad866c1] bitops: define const_*() versions of the non-atomics
>> git bisect good bb7379bfa680bd48b468e856475778db2ad866c1
>> # bad: [b03fc1173c0c2bb8fad61902a862985cecdc4b1b] bitops: let optimize out non-atomic bitops on compile-time constants
>> git bisect bad b03fc1173c0c2bb8fad61902a862985cecdc4b1b
>> # good: [e69eb9c460f128b71c6b995d75a05244e4b6cc3e] bitops: wrap non-atomic bitops with a transparent macro
>> git bisect good e69eb9c460f128b71c6b995d75a05244e4b6cc3e
>> # first bad commit: [b03fc1173c0c2bb8fad61902a862985cecdc4b1b] bitops: let optimize out non-atomic bitops on compile-time constants
> 
> Thanks,
> Olek

