From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some architectures
Date: Sun, 05 Mar 2023 21:10:31 +0100
Message-ID: <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-3-bhe@redhat.com> <87sfej1rie.fsf@mpe.ellerman.id.au>
 <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678047053; x=1678133453; bh=cjW13UmZQsjwyJDeHx5kIcthGLujwjX/c4O
        TYrUnVEo=; b=M+iX57D3tki6mdnYuiW2+/TVDcTnCB2Ga/GIjvvg25JyIDtZhzU
        mLkYC+yAY4SFZTnNttwjLlO8DD8yCYVw2kqWR6oHe88HECHGwU2I7Axt7fx139oN
        etVdN33n4Awn9hGCJAMtMjqHAQtx2VRikVcaIkNPJ7OSOLVm6//NltGUsHzgIj37
        6Q3ejPZj5Yi2cHI9b414CB+2Y/WNWnifgSj0Gzxyz7KQ4KCQRarWS5CulHYbi5eC
        ag9J4dSS2qmKbTaLa9/5xYv+fAFL3Yxj7jbc/4GSpKvlOtsPrPUdGxBgQX6SJ5Z/
        5TNCZ2yUU9mfrFdl1+bt1hfGmpR+ALzk/+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1678047053; x=1678133453; bh=cjW13UmZQsjwyJDeHx5kIcthGLujwjX/c4O
        TYrUnVEo=; b=CYjynxi2XdbvcwdySeuJXuc1PmUeES5qN5N0+ACWBaHPfzz2mdY
        KOtHjXR5RghXHpnlzSUA3NKQ8HzaPRpU50fjVFpJJj2Vy6sGAfy9/jRTA0VzqhBk
        8GsAumW0PCYRukJgw9SVPtwhkxwpu7ePss7hnK46F7qIf9wvuoF9/IIYqYHLSQ6S
        WYeQ8pkNDtW0oDCAUXUKxKH9ooj8BOTq4NG7N1mHccROcNqGiApuSD4gGmN67hlg
        /JkwqqShEOb8mieY78lGMfW+Gz28CVp4X2Co4shGbu4N41Qb30SR08YRmY/mYRXg
        wfIYMYkcUjgcGZeIAy669di3WjfqzK4B1xQ==
In-Reply-To: <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Luis Chamberlain <mcgrof@kernel.org>, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Sun, Mar 5, 2023, at 10:29, Geert Uytterhoeven wrote:
>
> On Sun, Mar 5, 2023 at 10:23=E2=80=AFAM Michael Ellerman <mpe@ellerman=
.id.au> wrote:
>> Maybe that exact code path is only reachable on x86/ia64? But if so
>> please explain why.
>>
>> Otherwise it looks like this series could break that driver on powerpc
>> at least.
>
> Indeed.

When I last looked into this, I sent a patch to use ioremap()
on non-x86:

https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/

    Arnd
