From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] hexagon: get rid of #include <generated/compile.h>
Date: Tue, 3 Oct 2017 10:26:14 +0900
Message-ID: <CAK7LNAQaGd5h5OHe5ArXV=wms07Zpd4OBPLrPYwZ68KpbjeGcQ@mail.gmail.com>
References: <1505920670-8290-1-git-send-email-yamada.masahiro@socionext.com> <20170927232415.GB5939@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com v931QtX7015637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1506994016;
        bh=6BhIg+ypqIYCtBNl2EIcekn6ytJ4rZxcE52a4NR+It8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=O7JDDaVi+Wb6PGOm2QloevUlUbmRg5c7zcHQE+4muFNAfV3tOEVkdMaBLZEfpjY+4
         pj5+xSnmGE9RLRAgF7uAiy3wLVRZirSWu3uT5z7kVuFjVaV/ZCW9fDjNvrJ0zV8p+T
         OwhkryuvsnwfuF7rRYC/rJpQo1gkWlqXk9JVIec1taYLx/PhXBwbmp9P3z+ead0ybm
         Xpbad44JvHfI82A9sAk9t8ZJVKdbeUFI14048jed9i2tMk4lxnstyBKXBuZiKp4Drp
         LfWjiDh2sT6/0kWVvLcVMOVc6jvYh7TN9PxT2eOXxbo5+b19fx1BmPD2MD+VOBa7vX
         lnEgWc1hG/PpQ==
In-Reply-To: <20170927232415.GB5939@codeaurora.org>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Richard,

2017-09-28 8:24 GMT+09:00 Richard Kuo <rkuo@codeaurora.org>:
> On Thu, Sep 21, 2017 at 12:17:50AM +0900, Masahiro Yamada wrote:
>> <generated/compile.h> is created (or updated) when Kbuild descends
>> into the init/ directory.  In parallel building from a pristine
>> source tree, there is no guarantee <generated/compile.h> exists when
>> arch/hexagon/kernel/ptrace.c is compiled.
>>
>> For hexagon architecture, we know UTS_MACHINE is a fixed string
>> "hexagon", so let's hard-code it, like many architectures do.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/hexagon/kernel/ptrace.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
>

How should this patch be handled?




-- 
Best Regards
Masahiro Yamada
