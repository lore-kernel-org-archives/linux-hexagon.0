From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 03/14] nds32: fix access_ok() checks in get/put_user
Date: Tue, 15 Feb 2022 10:18:15 +0100
Message-ID: <CAK8P3a1XkWNQcFEhJQ0+qWzih1YRQDS_N8xiosN7FHn3yoTJpQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-4-arnd@kernel.org>
 <YgqK1ihlJvRFHJ9h@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644916713;
        bh=auvbexz8OfCE17jezkrwExlxQUSMdLXG0OAD2bmLs8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R1Pf445AMn7iEf0TcHJGtZqUinPVYRIlRYIhUK+pqFhNMydlmGdLOnDcwqdoOpcxv
         rM+QtlC5MX40dddlY60U1EemOtvK01KeP4rBm30AWnHXp/wG3B2AqNZ0rlunLaOMbW
         tr7Vs0w/mpIoN0XApZa80K1xHxowMUZXp7dP4/BbBM9W+v5sudL1uLbQT49sSxdXFp
         TQxXAYDRaUN8F2rMT1u+N/nJuunLdz+VObtLisWpW965HLfjJNrl621lEvA4NBgly+
         FEKN2xUIJ9o0fBCy3UJA1PmxKT+NsxLFmCAClaf0u/3M6fW1/dPCwNdFwRQIJqLuEw
         iPMY1EoXY49Bg==
In-Reply-To: <YgqK1ihlJvRFHJ9h@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-s390 <linux-s39>

On Mon, Feb 14, 2022 at 6:01 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The get_user()/put_user() functions are meant to check for
> > access_ok(), while the __get_user()/__put_user() functions
> > don't.
> >
> > This broke in 4.19 for nds32, when it gained an extraneous
> > check in __get_user(), but lost the check it needs in
> > __put_user().
>
> Can we follow the lead of MIPS (which this was originally copied
> from I think) and kill the pointless __get/put_user_check wrapper
> that just obsfucate the code?

I had another look, but I think that would be a bigger change than
I want to have in a fix for stable backports, as nds32 also uses
the _check versions in __{get,put}_user_error.

If we instead clean it up in a separate patch, it should be done for
all eight architectures that do the same thing, but at that point,
the time seems better spent at coming up with a new set of
calling conventions that work with asm-goto.

         Arnd
