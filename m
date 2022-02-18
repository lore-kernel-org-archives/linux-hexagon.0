From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
Date: Fri, 18 Feb 2022 13:18:03 +0300
Message-ID: <Yg9yWxqD4RO7jI2g@curiosity>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-19-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ZwRbT+1qqEejXkPLNRT0P8U1UfOqBbbk2S+jBiDX7w=;
        b=HwIPNQm6bvP1qyt1DqVyrK6i1IxYBe3pF4kvKD1l9aL3skpcmD5TAiFiTR6vJgOz7B
         t0z9AUGb6zG6pfmU+9BHmWZjjYP8p3JYLtLTfoKdh3BnjyAxS8kyH7aEYnXi01jFZIzF
         573soHdCsmr3/P5ZM1x4mLpZvC48QquGUZEsW8SQQoM18/kWlPpgaxZHrqDS4b16t7Hk
         CPrKR07D3pDZ+6DpMa26njx9Ou6mX/WqALsfbj1Nd6drypXMoKGnpqS7eLYJp4gC/zQZ
         HSj8/Kstfvi7dLE4U0H5uDSTCcko9eMQl/aHEl20oLYR3YeK8yM1gI0YoPwa5+wSkB+m
         kvAQ==
Content-Disposition: inline
In-Reply-To: <20220216131332.1489939-19-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org

Hi Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are no remaining callers of set_fs(), so CONFIG_SET_FS
> can be removed globally, along with the thread_info field and
> any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
> 
> With CONFIG_SET_FS gone, so drop all remaining references to
> set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Sergey Matyukevich <sergey.matyukevich@synopsys.com> # for arc changes

Regards,
Sergey
