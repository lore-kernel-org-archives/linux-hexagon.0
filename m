From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Date: Tue, 07 Mar 2023 11:58:27 +1100
Message-ID: <87jzzt1ioc.fsf@mpe.ellerman.id.au>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-3-bhe@redhat.com>
 <87sfej1rie.fsf@mpe.ellerman.id.au>
 <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
 <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678150712;
        bh=CHWXVrMkdiyq4zwPZtjE+TsoQPPFRbjP3aPXqFScr8M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KWVVCGW43d7K7bKL3+7NAS3VQRFJRrNz2O6qEQSCe3iM0mAGIBLB0wpEx+hq1cgob
         zWrSY4r1DMNDvtk/jqhxoZ30OwLv16WASzFeifWZILoHN3jHCWsvTtmBOnGX3qdRK6
         l1lpOlGCLel5N3Z1MvgzoxbYsYBqPF6aKYYqR7dABs1WFXYIYTtmKn0P0o/cEKa8ya
         lW8DcOqf6hegaMGqy2+XpmpZ19j9hAutwRaz8eg/A2Sun/lZdLj8UX1yrRseK7ub8j
         6WcXKAD8niU8B//ISRCJPfq1nUy29cV9iN/fMEEr0y6Zvit+Gu412hJF5m69g5zV8B
         6ECeucihx/xAg==
In-Reply-To: <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Luis Chamberlain <mcgrof@kernel.org>, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Sun, Mar 5, 2023, at 10:29, Geert Uytterhoeven wrote:
>> On Sun, Mar 5, 2023 at 10:23=E2=80=AFAM Michael Ellerman <mpe@ellerman.i=
d.au> wrote:
>>> Maybe that exact code path is only reachable on x86/ia64? But if so
>>> please explain why.
>>>
>>> Otherwise it looks like this series could break that driver on powerpc
>>> at least.
>>
>> Indeed.
>
> When I last looked into this, I sent a patch to use ioremap()
> on non-x86:
>
> https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/

OK thanks.

Baoquan can you add that patch to the start of this series if/when you
post the next version?

cheers
