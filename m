From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 14:57:43 -0600
Message-ID: <CAHrUA36nBSP56wryRx8_7dSBLDSuTB3HgLRSQa5t7hbaKLPQgw@mail.gmail.com>
References: <1163031361018389@web26d.yandex.ru> <1361593470.29465.17@driftwood>
 <1982671361708622@web15h.yandex.ru> <1361861719.15497.0@driftwood>
 <195171361907160@web18e.yandex.ru> <CAHrUA35uwyu5mX3MPxC7AV6qWZ_R6DdBJLp=s78m-1hd3S2RCg@mail.gmail.com>
 <9881361910350@web24g.yandex.ru>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/2e28W8SDNUC6v1eO+uUzp3V6iLYyXcXs9gjjjbDPdg=;
        b=GSjmOsSa4OjLDseDC/3mlfLwUkmAOsUFi6C+E57yvCZj1CSlaoMFDVwUTyi6KYz/oJ
         8e4E6o9olvY53mM4ZMl8qcyqzjw6+lx6Kfd0oFvGlcFvN9i+6Hi3B/V32P1CTi5SR7v1
         OYMM86PZH8/exB/kXjoRpQ2E70Tey593fxvbKhi8EOKMKmxA+U8NXcVMxtYeAVSC4a4O
         G8HPI+jYNskxT6yZlsP6K6pjKunwit2fiQ98YaltPjW8gwfN1b7oWJuyd/lL+W7btGBx
         Wz9ZJ6svpzv76dt0vIyyZJPcbzeTBv3zZMgHHvo6Rj6iGbsnQIkyTe8TRdXBdrfpkY8o
         iV2w==
In-Reply-To: <9881361910350@web24g.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 26 February 2013 14:25,  <cotulla@yandex.ua> wrote:

> Hexagon has same addresses for most shared devices except the private ones - like timers and second level interrupt controller.
> For example, I am using exactly same base address for USB and it works.

Hmm. That's odd. Certainly, the formal specs for the chipset put them
in different places, but this all depends on how you set up various
registers during boot.  Note, FYI, that among other things, that there
are registers than can make devices and address ranges
appear/disappear  for the various different cpus -- this was meant as
both a security and convenience feature, so that e.g. the arm and
hexagon would not both try to use the same device at the same time, or
that e.g. the radio modem could be hidden.

Again, the whole point of the device tree is to allow base addresses
to be boot-time configured, so that a given driver could work on a
variety of different systems.

>>  I had started work on this, but I don't remember that I ever got it
>>  clean enough to submit upstream.  That plus the fact that interrupt
>>  routing was different:  hexagon has both second and third-level
>>  interrupt controllers, with ethernet being on a third-level
>>  controller.  I'd gotten much/most of the 2nd-level code done, and some
>>  of the 3rd-level code done, and I think its in the mainline kernel
>>  now, although I remember planning to do some more simplification and
>>  cleanup.
> Hm it seems dependent from SoC.

Yes, very much so.  And there are many different SoC's.

> In QDS8250B there are two second level interrupt controllers (SIRC)
> In common it can handle (32 - 2) + 2 * 32 interrupts.
> I already got SIRC to work and receive USB interrupts without problems.

Yep. And some of the SIRC's are routed to several third-level
controllers.  I vaguely remember there being 168 interrupts total, or
something like that.

And, BTW, there's some craziness, where different devices can be
multiplexed onto a given interrupt line; its really crazy, but
everything that you would normally be interested in was default.  I
don't remember what the other crazy stuff was  ..video controllers or
dma engines or something like that.

--linas
