From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 19 Feb 2013 08:29:34 -0600
Message-ID: <CAHrUA355zSNYgc4uFuSPRakNRq9PptqcgzsAK9+rO7s1ecdOZA@mail.gmail.com>
References: <1093431360938494@web22d.yandex.ru> <CAHrUA364XES66kXhr0Gg1dh_MQBAS0+R8Q4x+EY3dgz6s=QRww@mail.gmail.com>
 <CAHrUA36mN-a6BTCp7DP-QgWA5ii86YbmpvZbBTnv__f0mqft6g@mail.gmail.com>
 <1433341360978513@web2h.yandex.ru> <CAHrUA3676_qeiAR7MXbYd6aFAgFpr6GC9k3Xz+wyvHk56ebXiA@mail.gmail.com>
 <1163031361018389@web26d.yandex.ru> <20130219043605.GB12127@codeaurora.org>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=naz3g89pw2FfTqLhdsc840+/rkTpo8CHBQMddQwdkBs=;
        b=XRgBCDtlkLFYEPS+/XT2/2RmVBcMuBhqADYvqVAd5ThSMbjq7aG9SYKHR/QkWsxcxd
         azemC2v82cy/KRVTsrmt3xPJl1K1pm36Xg/nifTANbdUT1juhQStn+k0liuFpoMKuKwz
         VB09kSnfp++6wbv5p/VjZNjZZdweFSOLA+UX5vDMVARKSVQ0ugr6sFc7iovBl4PiEjmL
         2ZYftHT81nPtS+Of6GRYBeXvfLwiDJGWlR4SWbPM4s8+gzB0pNStWgL7Fse6nkg3MVwo
         2WtxqwqG/ONQXPM8p+8SFryw8LUCevuqJzYn55xwHebitpNsX/f3GZdTP13b5c3sp7cI
         XdjQ==
In-Reply-To: <20130219043605.GB12127@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rkuo <rkuo@codeaurora.org>
Cc: cotulla@yandex.ua, linux-hexagon@vger.kernel.org

On 18 February 2013 22:36, rkuo <rkuo@codeaurora.org> wrote:
> On Sat, Feb 16, 2013 at 04:39:49PM +0400, cotulla@yandex.ua wrote:
>> >  Don't know v2. But v3 had a 'real' MMU
>> Hm, are you sure in that?
>> I had never seen any usage of it. As well as binutils registers definition doesn't include any suitable registers for that.
>
> Both have an MMU, but both are software managed.  That's one of the
> functions that the hypervisor provides for us.

I might be confused, but I believe that this is actually very common;
the difference is that the so-called 'hardware MMU''s are actually
just nanocode burned into a ROM that's on the cpu chip die.  Its
invisible to the user. FWIW some deprecated instructions are also
emulated this way: they fault to a handler. You can hide a lot of
stuff this way. The powerpc does this, they learned it from the
mainframe 370/390 architecture, which abuses this (did you really
think the 'startio' instruction, which behaves like a DMA device
driver, was actually a single cycle hardware instruction?)

The hexagon doesn't have a (self-loading) ROM, so the mini-VM has to
be loaded at boot.

-- Linas
