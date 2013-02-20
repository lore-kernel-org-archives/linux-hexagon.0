From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Wed, 20 Feb 2013 05:07:46 +0400
Message-ID: <721691361322466@web24g.yandex.ru>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
 <1433341360978513@web2h.yandex.ru> <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
 <1163031361018389@web26d.yandex.ru> <20130219043605.GB12127@codeaurora.org> <CAHrUA355zSNYgc4uFuSPRakNRq9PptqcgzsAK9+rO7s1ecdOZA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361322467; bh=fyT9XQVJ6zjpZp6yRQ2wv6f04J8n/gjld74UeZiEnCw=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=XEURyNdt6hhOk3jc4WinRMBqnRUwoTiiFjPtsCE/v/VE0w7HG7zXsSVGognHkgaFi
	 wT9N5P4a2R1foi/jQ4+aSsxu2xx4+qN8jL65DwP1XjQvRtG5NAia7Uu84TxLaeN/SB
	 B0FnJPz8FZwA+Aitj9WAawHH2A72xBbqbS0Ikv64=
In-Reply-To: <CAHrUA355zSNYgc4uFuSPRakNRq9PptqcgzsAK9+rO7s1ecdOZA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9AI might be confused, but I believe that this is actually very comm=
on;
> =9Athe difference is that the so-called 'hardware MMU''s are actually
> =9Ajust nanocode burned into a ROM that's on the cpu chip die. =9AIts
> =9Ainvisible to the user. FWIW some deprecated instructions are also
> =9Aemulated this way: they fault to a handler. You can hide a lot of
> =9Astuff this way. The powerpc does this, they learned it from the
> =9Amainframe 370/390 architecture, which abuses this (did you really
> =9Athink the 'startio' instruction, which behaves like a DMA device
> =9Adriver, was actually a single cycle hardware instruction?)
>
> =9AThe hexagon doesn't have a (self-loading) ROM, so the mini-VM has =
to
> =9Abe loaded at boot.
>

I mean that Hexagon has a simular thing like MIPS.=20
Unlike ARM hardware does not fetch page table entries from RAM, it's us=
ing standalone TLB entries.
In ARM they are also present but usually ever low level code doesn't wo=
rk with them, low level code works with page tables in the RAM.


-Cotulla
