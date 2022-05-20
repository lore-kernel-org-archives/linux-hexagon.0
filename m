From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/5] kallsyms: pass buffer size in sprint_* APIs
Date: Fri, 20 May 2022 15:52:01 -0400
Message-ID: <f3627eae-f5ae-1d30-2c09-1820a255334a@redhat.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
 <CGME20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0@epcas5p1.samsung.com>
 <20220520083701.2610975-2-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-scsi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653076327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QC4HhoSa5ax5VuJxdudrkP+hQQcM6Ir26+NRsLLyTuA=;
        b=ffQP1iKEMwLMmrtyPuBVnKzkaESIyAH/D4BLawvxVHbL0maTnHQkKktVPETsUQGsEUGsl3
        ayuKfsnF6KSsYNQJeMAPPzma00ZUvLhn7/o772YAc3vrbzAYnIT1VkNE3Jof/uOgL+lJT1
        uOQ8NOTCTZVH8g0/Br/wucCEHglnytA=
Content-Language: en-US
In-Reply-To: <20220520083701.2610975-2-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Maninder Singh <maninder1.s@samsung.com>, keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org, jason.wessel@windriver.com, daniel.thompson@linaro.org, dianders@chromium.org, naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org, senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, akpm@linux-foundation
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-modules@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com, onkarnath.1@samsung.com

On 5/20/22 04:36, Maninder Singh wrote:
> As of now sprint_* APIs don't pass buffer size as an argument
> and use sprintf directly.
>
> To replace dangerous sprintf API to scnprintf,
> buffer size is required in arguments.
>
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>   arch/s390/lib/test_unwind.c    |  2 +-
>   drivers/scsi/fnic/fnic_trace.c |  8 ++++----
>   include/linux/kallsyms.h       | 20 ++++++++++----------
>   init/main.c                    |  2 +-
>   kernel/kallsyms.c              | 27 ++++++++++++++++-----------
>   kernel/trace/trace_output.c    |  2 +-
>   lib/vsprintf.c                 | 10 +++++-----
>   7 files changed, 38 insertions(+), 33 deletions(-)
>
> diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
> index 5a053b393d5c..adbc2b53db16 100644
> --- a/arch/s390/lib/test_unwind.c
> +++ b/arch/s390/lib/test_unwind.c
> @@ -75,7 +75,7 @@ static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs,
>   			ret = -EINVAL;
>   			break;
>   		}
> -		sprint_symbol(sym, addr);
> +		sprint_symbol(sym, KSYM_SYMBOL_LEN, addr);

Instead of hardcoding KSYM_SYMBOL_LEN everywhere, will it better to hide 
it like this:

         extern int __sprint_symbol(char *buffer, size_t size, unsigned 
long address);
         #define sprint_symbol(buf, addr)        __sprint_symbol(buf, 
sizeof(buf), addr)

Or you can use sizeof(buf) directly instead of KSYM_SYMBOL_LEN.

Cheers,
Longman

