From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] hexagon: get rid of #include <generated/compile.h>
Date: Mon, 9 Oct 2017 23:25:28 +0900
Message-ID: <CAK7LNARd6ovx=qmny1micPx7BUXf9uL9soES_OcotF-bYCCQWw@mail.gmail.com>
References: <1505920670-8290-1-git-send-email-yamada.masahiro@socionext.com>
 <20170927232415.GB5939@codeaurora.org> <CAK7LNAQaGd5h5OHe5ArXV=wms07Zpd4OBPLrPYwZ68KpbjeGcQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com v99EQ9KX011907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1507559170;
        bh=kwuGnvtamwrJDmxDCxN28D8QZtD2QQac23bTots6j8o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jeZkkQ/SCVxSZthBPGM2mMCuXnoAWB8D4kOhtf+kGqDEUplrseoqs6/hG8QYjpBS/
         I0ykXuYSba7S4i2X15NpWiEl4m2NR1Nc5QJrRcgD2dYosunBxNo/nOwkrVg7Ztw4TP
         6gIaEPysJaBfLw1CLsb+YDlwba0tVlzx5COoILpmgZuQLYQ9gSmthwJb4po8P0YABA
         Yvgs3ppWoTuD1xeEHOmfGor8v+HErPHtJxxhUjjmRvIwlqoUuBlSHqktB3S+pYHAQw
         kAD6GiTnwCG/mNnRK2ouBJAI57F8GUsSE3MJ//cJIH+k4pdBIre68Aw0qLOITYounv
         oBvE4a2ET7uVA==
In-Reply-To: <CAK7LNAQaGd5h5OHe5ArXV=wms07Zpd4OBPLrPYwZ68KpbjeGcQ@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-10-03 10:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Richard,
>
> 2017-09-28 8:24 GMT+09:00 Richard Kuo <rkuo@codeaurora.org>:
>> On Thu, Sep 21, 2017 at 12:17:50AM +0900, Masahiro Yamada wrote:
>>> <generated/compile.h> is created (or updated) when Kbuild descends
>>> into the init/ directory.  In parallel building from a pristine
>>> source tree, there is no guarantee <generated/compile.h> exists when
>>> arch/hexagon/kernel/ptrace.c is compiled.
>>>
>>> For hexagon architecture, we know UTS_MACHINE is a fixed string
>>> "hexagon", so let's hard-code it, like many architectures do.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  arch/hexagon/kernel/ptrace.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>
>> Acked-by: Richard Kuo <rkuo@codeaurora.org>
>>
>
> How should this patch be handled?
>

I checked
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git

I could not see any patch applied to the tree since last year.

Assuming the tree is unmaintained, I am picking this patch to Kbuild tree.



Applied to linux-kbuild/kbuild with Rechard's Acked.



-- 
Best Regards
Masahiro Yamada
