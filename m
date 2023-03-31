From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 17/21] ARM: dma-mapping: use arch_sync_dma_for_{device,cpu}()
 internally
Date: Fri, 31 Mar 2023 14:48:34 +0200
Message-ID: <f3637818-7528-4564-a208-6e587efd7128@app.fastmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-18-arnd@kernel.org>
 <CACRpkdZdnTX4-jnnXZveXxwOg76yH4Zyoa-ZSGeC7KzOnn+6Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1680266936; x=1680274136; bh=1wl0PaNqVV1tf/UjJBVG7Hr1Nf6zuThoMUu
	qGEpn1MA=; b=BLukJoG1DbMb6R2AbqA/+7JjbZ7Oc/VY/GccCFivK2SLSyJIUDy
	eDvuj6KlJ9yQrHhbcVFZFc/7GfKYkkIJnc004z0WtfxhzT8F0Dryc/fj4uAQEHP5
	0uQBdRp2Y9CzikgGULwwka03ZtEYN+vA0NR1UYoJiMuMTtA+TbmqSw1RKb6bHBwu
	kgWKCmrmDScSe7b7EAcsyIEqiEeMn1uQFjhnq/BazbUn1vodHcRar+Z8amV+f2ZZ
	4SEu3kvSxhj8jR9TWpWv6H7rDT3W+eYIj1h32pDouk8U16vHi7UxgZYWiVlTR8pm
	cvHgSREjUd2DJv11jgWTdKV0doKNHN4KAQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1680266936; x=1680274136; bh=1wl0PaNqVV1tf/UjJBVG7Hr1Nf6zuThoMUu
	qGEpn1MA=; b=QTw4z9BqGCp34jRTQ9lJ0Te2z7DjXCcjR1cRFuymA6teq1Ue47T
	RfmowyRx6v1MwMbGt3ApYDk7qwSROS25JV78fgnvrSJIUz/j3GedCAWFmvE8DLl3
	HoMeyCJb5WbZ+f8j44/HhL12AZyMqN3xRjT/IDdrxGjXOHILLMDS4nNm1QNzKgnt
	FLCEk9P9FtfqKPKXWuMbSuG7oHcgCKFsVXQhQDt+sRTlprJiPAhFBhU6avHf2Ete
	uaofk0N4pXe1j7VHba5yYeMGTXuCjt30lCiXSGhI7m4EIcITbbYAAY9vnjAdi0d+
	SAs1yBNQ6aJg2m3zpufn0UV2fnpNcc/oKsQ==
In-Reply-To: <CACRpkdZdnTX4-jnnXZveXxwOg76yH4Zyoa-ZSGeC7KzOnn+6Lg@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="windows-1252"
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, "Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Brian Cain <bcain@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-m68k@lists.linux-m68k.org, Paul Walmsley <paul.walmsley@sifive.com>, Stafford Horne <shorne@gmail.com>, linu

On Fri, Mar 31, 2023, at 11:10, Linus Walleij wrote:
> On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The arm specific iommu code in dma-mapping.c uses the page+offset bas=
ed
>> __dma_page_cpu_to_dev()/__dma_page_dev_to_cpu() helpers in place of t=
he
>> phys_addr_t based arch_sync_dma_for_device()/arch_sync_dma_for_cpu()
>> wrappers around the.
>
> Broken sentence?

I've changed s/the/them/ now, at least I think that's what I meant to
write in the first place.

>> In order to be able to move the latter part set of functions into
>> common code, change the iommu implementation to use them directly
>> and remove the internal ones as a separate interface.
>>
>> As page+offset and phys_address are equivalent, but are used in
>> different parts of the code here, this allows removing some of
>> the conversion but adds them elsewhere.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks good to me, took me some time to verify and understand
> the open-coded version of PFN_UP() and this refactoring alone
> makes the patch highly valuable.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

    ARnd
