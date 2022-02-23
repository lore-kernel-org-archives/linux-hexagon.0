From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
Date: Wed, 23 Feb 2022 12:05:04 -0800
Message-ID: <CAHk-=wjdHz6OU3M9T5zE9Fc9SNdDs52iOE+eVn-wuUT6UDpBLg@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S6BFzj6o5ckty5iXSThNrfkPsdFE94/fVb8NP4+aFs=;
        b=F/2f/aEUKxSuzDdCknAbug+t8clrlE0v7gj9NkhphhHftuFg6XGIjvpJXVx+ZHKhn9
         jOIdz4l7lK+/F1JhXkxR/PARyehOhzu1/S93ijWQKe7fGKOKTiRs9R81aIq3OYNVOgnf
         G4UcKLBEtMgH8cssPIzV42vV3R64/Z0YRVhdY=
In-Reply-To: <20220221132456.GA7139@alpha.franken.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@in>

On Mon, Feb 21, 2022 at 5:25 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> With this patch
[ .. snip snip ..]
> I at least get my simple test cases fixed, but I'm not sure this is
> correct.

I think you really want to do that anyway, just to get things like
wild kernel pointers right (ie think get_kernel_nofault() and friends
for ftrace etc).

They shouldn't happen in any normal situation, but those kinds of
unverified pointers is why we _have_ get_kernel_nofault() in the first
place.

On x86-64, the roughly equivalent situation is that addresses that
aren't in canonical format do not take a #PF (page fault), they take a
#GP (general protection) fault.

So I think you want to do that fixup_exception() for any possible addresses.

> Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> for the 32bit case ?

I would suggest against using a non-constant TASK_SIZE_MAX. Being
constant is literally one reason why it exists, when TASK_SIZE itself
has often been about other things (ie "32-bit process").

Having to load variables for things like get_user() is annoying, if
you could do it with a simple constant instead (where that "simple"
part is to avoid having to load big values from a constant pool -
often constants like "high bit set" can be loaded and compared against
more efficiently).

               Linus
