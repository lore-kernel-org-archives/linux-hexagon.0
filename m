From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 0/3] hexagon: Fix build error with CONFIG_STACKDEPOT and
 select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
Date: Tue, 15 Jun 2021 10:25:37 -0700
Message-ID: <YMjikYQsA9DmyRm8@MSI.localdomain>
References: <20210521011239.1332345-1-nathan@kernel.org>
 <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
 <09a301d75899$daf244f0$90d6ced0$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623777940;
        bh=Eci6k0g98Hgau9oCi1zhhBUfXGggZ42HI8rbMPNXZKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4qkUho5RFYScbT9ZStz7qn9cL97C2AbBgI051qEdWClV5xzZzT4FCl9mCzDWnHvq
         60qYEehCUxccqwY/CLKr1GTq/cEduItxmS+7E/HgEc2rNFttwWgHrQpvZzYm2/HCvF
         FTQ1IbzpsjN6J7N9M+6mrVUYivLQK4icUxFhdpT2Q6Hh+t0rtYs44Lz1LkFHBJcjh8
         1wlFSHGVjPn1sGePXp8TEYVJ0YCdrVG8ADo0kTRtrWY0bBGtRJC9z3UMlSTZsuGrJV
         4JpA6TN1vnWW38dwLf8N9LTMthLVL6RLCwdfuWJiJxfAah8IoKWedhLRbC7lOdVt2e
         4+xSkmA/UqryA==
Content-Disposition: inline
In-Reply-To: <09a301d75899$daf244f0$90d6ced0$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Thu, Jun 03, 2021 at 11:59:43AM -0500, Brian Cain wrote:
> > -----Original Message-----
> > From: Nathan Chancellor <nathan@kernel.org>
> ...
> > On 5/20/2021 6:12 PM, Nathan Chancellor wrote:
> > > Hi all,
> ...
> > Brian, did you have any comments on this series? ARCH=hexagon defconfig
> > is currently broken in -next, it would be a real shame if this continued
> > to regress after you just got Hexagon building in mainline. These
> > patches seem like they would be worthy of a 5.13 pull request.
> 
> I have started the internal review process to get these queued up in my tree.  But I don't know if I would have it in time for 5.13.
> 
> > Otherwise, Andrew could pick them up with your ack and stick them in
> > front of "mm/slub: use stackdepot to save stack trace in objects" so
> > that there is no build regression.
> 
> Of course: I'll send my ack for the sake of keeping the build green.
> 
> -Brian

Andrew, is there any way you can pick this up so that the Hexagon build
can start being green? I explained the issue in the cover letter so that
you know where to stick this patch set in your stack. If you have any
more questions, please let me know.

Cheers,
Nathan
