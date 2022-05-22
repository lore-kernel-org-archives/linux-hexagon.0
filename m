From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Date: Sat, 21 May 2022 23:07:52 -0700
Message-ID: <YonTOL4zC4CytVrn@infradead.org>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
 <20220520083701.2610975-1-maninder1.s@samsung.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8vODVBPPT4aieHBVtPQZPwEE8oetsAgiBP0SHP03Ns=; b=dVrwKB+az4x8MRcYyIRObMC3Kz
        0/Lk5RsZ/uHq7rxWTwLfDctoffMnHd/XYI6CywnbwDoBtQ0kGP0IAReMVRjqBcN7i0SOfz0WyQzjA
        72LMGsN8V9ohaRMa+yuZL8XoU9VwEiQiE2PgbZvQra5fAtbw50/0JLdprjgLYkqxfuWFiZ6BP/ylm
        NxxYXDcrYvan5XviHSu6Iu2oEMAP9rTCG164FVGAiNtLsWVSqGCba2HcD3pGV4AYzuLQExeQAeT4l
        L1Dtehj+OTr3rq74yGZS0MDlKvD/f3IME9yzaWi1wHGZN47KQaz/+4mUl1RmIeJIrS4yLTIpAl1X9
        obWQzOxQ==;
Content-Disposition: inline
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maninder Singh <maninder1.s@samsung.com>
Cc: keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org, jason.wessel@windriver.com, daniel.thompson@linaro.org, dianders@chromium.org, naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, rostedt@goodmis.org, senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, arnd@arndb.de

On Fri, May 20, 2022 at 02:06:56PM +0530, Maninder Singh wrote:
> kallsyms functionality depends on KSYM_NAME_LEN directly.
> but if user passed array length lesser than it, sprintf
> can cause issues of buffer overflow attack.
> 
> So changing *sprint* and *lookup* APIs in this patch set
> to have buffer size as an argument and replacing sprintf with
> scnprintf.

This is still a pretty horrible API.  Passing something like
a struct seq_buf seems like the much better API here.  Also with
the amount of arguments and by reference passing it might be worth
to pass them as a structure while you're at it.

