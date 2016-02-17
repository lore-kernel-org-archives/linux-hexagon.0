From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/2] Consolidate redundant register/stack access code
Date: Wed, 17 Feb 2016 10:45:10 +0100
Message-ID: <20160217094510.GA27144@gmail.com>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
 <1455010600.13384.3.camel@ellerman.id.au>
 <20160209094526.GB25268@gmail.com>
 <56BA5226.3090105@linaro.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xmprIFgmSFkQNKi71fVnMSfFyniWePlWTNbOYYbAP3A=;
        b=ztR61/TooxTstJQYVoCIveXlPn7EgoAlSuh3SLFoPxPRnYqaVV8jitMzSY+52lhHRe
         XhlCSpl1bEpdThNZVNeA+aXns6izng32YYjjaZPfk/7yJHdAwVKb9k58U3YGwiL6tn3B
         ih+3UFwcNOJ4mdazmunJwahxgDZDgwp5JV4wmX3NpDPu07gOjQLm6zChMiDb1AkA/4rg
         h6wb0aLYVgOe3FpFGLj6HPz/RgN/WYiXpEX5VZfyApzIPl1oaomTc+HgiosdrqY4RjUU
         X+5con/Ec8NvNBidjJowQFiQSGl2LEhN0D/vozRh8Gjsn3aOuyiCXX89G5rWZ5C2PUQv
         lPjA==
Content-Disposition: inline
In-Reply-To: <56BA5226.3090105@linaro.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Long <dave.long@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Denys Vlasenko <dvlasenk@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmicy@gmail.com>, Rich Felker <dalias@libc.org>, Richard Kuo <rkuo@codeaurora.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@a>


* David Long <dave.long@linaro.org> wrote:

> On 02/09/2016 04:45 AM, Ingo Molnar wrote:
> >
> >* Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >>On Tue, 2016-02-09 at 00:38 -0500, David Long wrote:
> >>
> >>>From: "David A. Long" <dave.long@linaro.org>
> >>>
> >>>Move duplicate and functionally equivalent code for accessing registers
> >>>and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> >>>common kernel files.
> >>>
> >>>I'm sending this out again (with updated distribution list) because v2
> >>>just never got pulled in, even though I don't think there were any
> >>>outstanding issues.
> >>
> >>A big cross arch patch like this would often get taken by Andrew Morton, but
> >>AFAICS you didn't CC him - so I just added him, perhaps he'll pick it up for
> >>us :D
> >
> >The other problem is that the second patch is commingling changes to 6 separate
> >architectures:
> >
> >  16 files changed, 106 insertions(+), 343 deletions(-)
> >
> >that should probably be 6 separate patches. Easier to review, easier to bisect to,
> >easier to revert, etc.
> >
> >Thanks,
> >
> >	Ingo
> >
> 
> I see your point but I'm not sure it could have been broken into separate 
> successive patches that would each build for all architectures.

Why? AFAICS all the functionality appears to be conditional on 
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API, so it ought to build standalone as well, on 
a per arch basis, as long as the core kernel patch is applied first.

Thanks,

	Ingo
