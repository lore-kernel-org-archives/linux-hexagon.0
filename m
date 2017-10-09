From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: get rid of #include <generated/compile.h>
Date: Mon, 9 Oct 2017 11:31:42 -0500
Message-ID: <20171009163142.GA19621@codeaurora.org>
References: <1505920670-8290-1-git-send-email-yamada.masahiro@socionext.com>
 <20170927232415.GB5939@codeaurora.org>
 <CAK7LNAQaGd5h5OHe5ArXV=wms07Zpd4OBPLrPYwZ68KpbjeGcQ@mail.gmail.com>
 <CAK7LNARd6ovx=qmny1micPx7BUXf9uL9soES_OcotF-bYCCQWw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1507566706;
        bh=seWV9wXgxYcvGmr1v4NscGXz3cDZCCy/jaMVYIvkGw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7p1/gLi6CdFBh0KxFHD0OugHxdsnjQO82zfbvE5T3udfJg/okQZyp6sqwe97l5aI
         fn/17FqhsO3wV7FpDnNDYT0Kt6dJ4rUZ/2cgZOgquDJMVDNuOH/j4UFHaX1lMLxnUY
         7yJTMAfqsURA/4y3Uy+dWjeTH9hXDsZmWHnkGu2k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1507566704;
        bh=seWV9wXgxYcvGmr1v4NscGXz3cDZCCy/jaMVYIvkGw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xy2xuz54tLFuaPGn8qMjQLZyflv46C+x4u3pZhUhehqudhurxMTJF0/Ge0GvlVNi+
         wxoQXobOk5nM7jVRpHS9FSkx7jKGh9NyxG5160Y7RsRmnPniMYtX1N9eDP+cNa0DAu
         T7IE6aMMMMVSzBgvNVrXRFbnHCUmBXHMvG5Ws2Ac=
Content-Disposition: inline
In-Reply-To: <CAK7LNARd6ovx=qmny1micPx7BUXf9uL9soES_OcotF-bYCCQWw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-hexagon@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Oct 09, 2017 at 11:25:28PM +0900, Masahiro Yamada wrote:
> >>
> >
> > How should this patch be handled?
> >
> 
> I checked
> git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git
> 
> I could not see any patch applied to the tree since last year.
> 
> Assuming the tree is unmaintained, I am picking this patch to Kbuild tree.
> 
> 
> 
> Applied to linux-kbuild/kbuild with Rechard's Acked.
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada


Sorry about that.  For the record I'm fine with these patches going up
some of the other trees, like trivial or kbuild.  Might go faster that way.


Thanks,
Richard Kuo




-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
