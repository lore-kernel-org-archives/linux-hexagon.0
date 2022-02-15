From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/14] nds32: fix access_ok() checks in get/put_user
Date: Tue, 15 Feb 2022 11:25:44 +0100
Message-ID: <Ygt/qMduFQIjWqfU@kroah.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-4-arnd@kernel.org>
 <YgqK1ihlJvRFHJ9h@infradead.org>
 <CAK8P3a1XkWNQcFEhJQ0+qWzih1YRQDS_N8xiosN7FHn3yoTJpQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644920748;
        bh=ff3JsyoyvYlhG8jzgNCTPV8IRM6/qaYw6mQrNFy9F74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Idtvq2yMUPVIjRWGD6CbxsSP8vfjonXBjhqjw0KPeSxq9WG+eJI9q3VMhGdj4sPiw
         td4MlzEZussptBdaheJ5yjhE4vnfocIKiMf6Eye4k3uvvU7zndbY9d/28Z7fJPAVjQ
         V+ay13tyZYzyUl7pHGRP2ddUQDwCe4rTDO0IODfo=
Content-Disposition: inline
In-Reply-To: <CAK8P3a1XkWNQcFEhJQ0+qWzih1YRQDS_N8xiosN7FHn3yoTJpQ@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <>

On Tue, Feb 15, 2022 at 10:18:15AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 14, 2022 at 6:01 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The get_user()/put_user() functions are meant to check for
> > > access_ok(), while the __get_user()/__put_user() functions
> > > don't.
> > >
> > > This broke in 4.19 for nds32, when it gained an extraneous
> > > check in __get_user(), but lost the check it needs in
> > > __put_user().
> >
> > Can we follow the lead of MIPS (which this was originally copied
> > from I think) and kill the pointless __get/put_user_check wrapper
> > that just obsfucate the code?
> 
> I had another look, but I think that would be a bigger change than
> I want to have in a fix for stable backports, as nds32 also uses
> the _check versions in __{get,put}_user_error.

Don't worry about stable backports first, get it correct and merged and
then worry about them if you really have to.

If someone cares about nds32 for stable kernels, they can do the
backport work :)

thanks,

greg k-h
