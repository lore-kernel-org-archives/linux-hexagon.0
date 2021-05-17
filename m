From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 4/6] [v2] arc: use generic strncpy/strnlen from_user
Date: Mon, 17 May 2021 08:47:18 +0200
Message-ID: <CAK8P3a12HtG7GZHikZa73SbKKr9QhDWgi6BcMwM-W=U1bpewGw@mail.gmail.com>
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-5-arnd@kernel.org>
 <20210517061656.GB23581@lst.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621234107;
        bh=XwMg9QqAApvxACMmxOXgBWUrqiIh4WJcvsyjh85BX2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJt9dRt9/P1Oeb+0iWbP7PGy1GVoBntHTUDRSoynf/8phrjMncmBI/ggwMFlKlmA4
         uuwdcgFzPVyWcULWZZMV+PDvUGYAtGLZjcJeqxnAGFgXsSTbo1iqNuX9RovAK1NMog
         v5E3xwNbYKKDTqYEhc8XqxdiPvJx8qxsysv0JpQTmDcI5dtqsts3rcOkmicLWGs+LZ
         I3s4EXsVmmEK7pQkyBarkV2O524+ajYdjoiX+3tbSceN1/Ilqa5FIhlDMZxDYnNs2Y
         PSrfMm1aeEIRhIwAaAgAbu/Cnzpc0lWpV5FQ3orgCW60gOeRfFqR8rngxAhVGG2A3o
         DjkPheDPLSvvQ==
In-Reply-To: <20210517061656.GB23581@lst.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Sid Manning <sidneym@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, moderated list:H8/300 ARCHITECTURE

On Mon, May 17, 2021 at 8:16 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, May 15, 2021 at 12:18:01PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most per-architecture versions of these functions are broken
> > in some form, and they are almost certainly slower than the
> > generic code as well.
> >
> > This version is fairly slow because it always does byte accesses
> > even for aligned data, and its checks for user_addr_max() differ
> > from the generic code.
> >
> > Remove the ones for arc and instead use the generic version.
>
> Same comment as for hexaon before.

Changed now.

     Arnd
