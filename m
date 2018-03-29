From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Thu, 29 Mar 2018 12:43:05 -0500
Message-ID: <1ec5d19a-d649-38bd-ab89-868e1ad9dd7f@landley.net>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
 <20180329152749.GC16141@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------292EE39B94C5DBED4CD25C9B"
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ygfLoaboICzDZcJFn5AHYjJipozuMe5fONsOZjyXfH8=; b=b6Q1ZQqLiLjHMS/4ZJtO0qf4w
	dHGlcFgiSKOqcLMiPMQ/lBmWVQ9COTNsU92DLheM02LFpNsBuZ9jq4kRrWAmfL83HWq5dge5ZTwkr
	ibKQ5bfBYTDQ3WMZDg0pbKVzNZ80VtVjI0ZrvFYSVoNKbA7t32fmD/7StNy3EnoM8LfyuXM5s0jv3
	keLbUxvhvRjUO4WFAZw5BIBz0O1wvrfcNyJHuEsWALVZQstT0XvMJrRIG+YbzqdtNryuYUCcuZqcS
	faRWlHDQ1z94GmDtwc6yVFmjfzZ9112z3rJMaA37PIyZcdub8T7aYtLAZh3BaFLkFxaCI+03cd7HU
	0amFPsLhQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=XYm81nFVNoG1ewXl1m2LzOEska8lq95mNWr4Z6VDGjw=;
 b=y+2eclM0AHRnnlmmpWVA5ToVQmte8qRM89ggtql9WZKCHqnqaKFqqMLFzMkGrUYgRT
 8S0SqkqTcA+p/xztDo3y2kIE5oB7ne3+gRDULOkian9o6j/db2k9dInBXcbjxIit1Twc
 jxugdJVzyTUdv85ZTQaQvatnW66dHmkLaWQvMFplclRY1e8UgXMjgfIPvbC8JYJgQZEE
 v2QNbCdTd5lQSH/kQtXcGWyMty/0YNV3EKdxjWPe5idO0TTUbJLqkLgUdHmu/RC77VXO
 EPmWs1TmSOpVzWlOIOXzUDdssJorjEZkR9/bKuHZ33s/x6R850ADd3/SgEzwLF8vfdCh
 Aliw==
In-Reply-To: <20180329152749.GC16141@n2100.armlinux.org.uk>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Oliver <oohall@gmail.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfou>

This is a multi-part message in MIME format.
--------------292EE39B94C5DBED4CD25C9B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 03/29/2018 10:27 AM, Russell King - ARM Linux wrote:
> On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
>> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
>>> LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
>>> what I can see, nothing selects it.  Therefore, the symbol is always
>>> disabled, and so the feature never gets used in mainline kernels.
>>>
>>> Brings up the obvious question - why is it there if it's completely
>>> unused?  (Maybe to cause confusion, and allowing a justification
>>> for __weak ?)
>>
>> IIRC Nick had some patches to do the arch enablement for powerpc, but
>> I'm not sure what happened to them though. I suspect it just fell down
>> Nick's ever growing TODO list.
> 
> I've given it a go on ARM, marking every linker-built table with KEEP()
> and comparing the System.map files.  The resulting kernel is around
> 150k smaller, which seems good.
> 
> However, it doesn't boot - and I don't know why.  Booting the kernel
> under kvmtool in a VM using virtio-console, I can find no way to get
> any kernel messages out of it.  Using lkvm debug, I can see that the
> PC is stuck inside die(), and that's the only information I have.

qemu-system-arm's "-s" option lets you hook to the hardware with gdb, as if
using one of those jtags that speaks gdbserver protocol. It stops waiting for
you to attach with 'target remote' it, then 'file vmlinux' to load the symbols...

The miniconfig and qemu invocation I use for arm64 are attached, tested with
2.11.0 on a 4.14 kernel. You should be able to just "qemu-aarch64.sh -s" and
then probably "target remote 127.0.0.1:1234"? (Been a while since I've used it,
don't have a cross-gdb for arm64 lying around...)

Sigh, I just tried -s and qemu 2.11.0 is _not_ waiting for gdb to attach on
arm64, despite what the docs say:

$ qemu-system-aarch64 --help | grep gdb
-gdb dev        wait for gdb connection on 'dev'
-s              shorthand for -gdb tcp::1234

Another random regression in qemu, gee what a surprise.

> It dies before bringing up the other CPUs, so it's a very early death.
> 
> I don't think other console types are available under ARM64.

I've often found useful the two line version of:

https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/

Which is generally some variant of:

{char *XX = "blah"; while (*XX) {while (*SERIAL_STATUS_REGISTER & OUT_READY);
*SERIAL_OUT = *XX++;}}

(I.E. balu cheated not spinning checking the ready-for-next-byte bit, because
qemu's always angry.)

That trick lets you cut and paste a print statement into all sorts of early
hardware nonsense, on most architectures. You just have to look up
SERIAL_STATUS_REGISTER, OUT_OK_BIT, and SERIAL_OUT values for the serial port du
jour.

That said I've mostly used it in things like u-boot. I dunno at what point the
kernel's done enough setup that direct banging on registers would stop working.
(Works in the decompresion code, anyway.) And it assumes the port's set to the
right speed (usually left there by the bootloader)...

Rob

--------------292EE39B94C5DBED4CD25C9B
Content-Type: text/plain; charset=UTF-8;
 name="aarch64.miniconf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="aarch64.miniconf"

IyBtYWtlIEFSQ0g9YXJtNjQgYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9YWFyY2g2
NC5taW5pY29uZgojIG1ha2UgQVJDSD1hcm02NCAtaiAkKG5wcm9jKQojIGJvb3QgYXJjaC9h
cm02NC9ib290L0ltYWdlCgoKQ09ORklHX01NVT15CkNPTkZJR19BUkNIX01VTFRJX1Y3PXkK
Q09ORklHX0FSQ0hfVklSVD15CkNPTkZJR19TT0NfRFJBN1hYPXkKQ09ORklHX0FSQ0hfT01B
UDJQTFVTX1RZUElDQUw9eQpDT05GSUdfQVJDSF9BTFBJTkU9eQpDT05GSUdfQVJNX1RIVU1C
PXkKQ09ORklHX1ZEU089eQpDT05GSUdfQ1BVX0lETEU9eQpDT05GSUdfQVJNX0NQVUlETEU9
eQpDT05GSUdfS0VSTkVMX01PREVfTkVPTj15CgpDT05GSUdfU0VSSUFMX0FNQkFfUEwwMTE9
eQpDT05GSUdfU0VSSUFMX0FNQkFfUEwwMTFfQ09OU09MRT15CgpDT05GSUdfUlRDX0NMQVNT
PXkKQ09ORklHX1JUQ19IQ1RPU1lTPXkKQ09ORklHX1JUQ19EUlZfUEwwMzE9eQoKQ09ORklH
X05FVF9DT1JFPXkKQ09ORklHX1ZJUlRJT19ORVQ9eQoKQ09ORklHX1BDST15CkNPTkZJR19Q
Q0lfSE9TVF9HRU5FUklDPXkKQ09ORklHX1ZJUlRJT19CTEs9eQpDT05GSUdfVklSVElPX1BD
ST15CkNPTkZJR19WSVJUSU9fTU1JTz15CgpDT05GSUdfQVRBPXkKQ09ORklHX0FUQV9TRkY9
eQpDT05GSUdfQVRBX0JNRE1BPXkKQ09ORklHX0FUQV9QSUlYPXkKCkNPTkZJR19QQVRBX1BM
QVRGT1JNPXkKQ09ORklHX1BBVEFfT0ZfUExBVEZPUk09eQpDT05GSUdfQVRBX0dFTkVSSUM9
eQoKCiMgQ09ORklHX0VNQkVEREVEIGlzIG5vdCBzZXQKQ09ORklHX0VBUkxZX1BSSU5USz15
CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9TQ1JJUFQ9eQpDT05GSUdfTk9f
SFo9eQpDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKCkNPTkZJR19CTEtfREVWPXkKQ09ORklH
X0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX1JEX0daSVA9eQoKQ09ORklHX0JMS19ERVZfTE9P
UD15CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VYVDRfVVNFX0ZPUl9FWFQyPXkKQ09ORklH
X1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfVVRGOD15CkNPTkZJR19NSVNDX0ZJTEVT
WVNURU1TPXkKQ09ORklHX1NRVUFTSEZTPXkKQ09ORklHX1NRVUFTSEZTX1hBVFRSPXkKQ09O
RklHX1NRVUFTSEZTX1pMSUI9eQpDT05GSUdfREVWVE1QRlM9eQpDT05GSUdfREVWVE1QRlNf
TU9VTlQ9eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfVE1QRlNfUE9TSVhfQUNMPXkKCkNPTkZJ
R19ORVQ9eQpDT05GSUdfUEFDS0VUPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNP
TkZJR19JUFY2PXkKQ09ORklHX05FVERFVklDRVM9eQojQ09ORklHX05FVF9DT1JFPXkKI0NP
TkZJR19ORVRDT05TT0xFPXkKQ09ORklHX0VUSEVSTkVUPXkKCg==
--------------292EE39B94C5DBED4CD25C9B
Content-Type: application/x-shellscript;
 name="qemu-aarch64.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qemu-aarch64.sh"

cWVtdS1zeXN0ZW0tYWFyY2g2NCAtcyAtTSB2aXJ0IC1jcHUgY29ydGV4LWE1NyAtbm9ncmFw
aGljIC1uby1yZWJvb3QgLW0gMjU2IC1hcHBlbmQgInBhbmljPTEgSE9TVD1hYXJjaDY0IGNv
bnNvbGU9dHR5QU1BMCIgLWtlcm5lbCBJbWFnZSAtaW5pdHJkIGFhcmNoNjQtbGludXgtbXVz
bGVhYmktcm9vdC5jcGlvLmd6ICIkQCIK
--------------292EE39B94C5DBED4CD25C9B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--------------292EE39B94C5DBED4CD25C9B--

