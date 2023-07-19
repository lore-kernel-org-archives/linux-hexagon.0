From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 4/9] vgacon, arch/*: remove unused screen_info
 definitions
Date: Wed, 19 Jul 2023 15:34:38 +0200
Message-ID: <f918a76f-324a-5c91-7dcc-5f5d43b247f6@linaro.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-5-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689773685; x=1692365685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iqyJ1tyt/zGintHwIRAOam+B9iGxWukjiMScggaplw=;
        b=tnwmFnoxmhunQP8kjZ6qRl/OGitVUDE3mJI4J0Bb9Bp8DUXPw7FUvoH4SJaponnIjO
         79/V5ps+CVomWPG8NqwqNbIO27SABfwVaVw3Mb6qZ7VdwIgmflhthWPDxDkyN+f84CyN
         Zq8sLp3Svrl/2foju6LSuOvdNyrJH3ic0TqeIW8z8qycFVYogIcRSsPJoWCvYQP1w8aL
         n/t1wnClJAh/vfLOvbGFPdk/C5OweTX/OB/xQHUXjfxicXFF43koJxJP4T8yqxoolLPE
         XjzgJzV1MbjftRFqHKBTG8TuBD/B+I1enQDU1ce3L3gmKkUdxXiX6YtiZQRcIeH2Vk5D
         97zw==
Content-Language: en-US
In-Reply-To: <20230719123944.3438363-5-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="macroman"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu->

T24gMTkvNy8yMyAxNDozOSwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBGcm9tOiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPgo+IAo+IEEgbnVtYmVyIG9mIGFyY2hpdGVjdHVyZXMgZWl0aGVy
IGtlcHQgdGhlIHNjcmVlbl9pbmZvIGRlZmluaXRpb24gZm9yCj4gaGlzdG9yaWNhbCBwdXJwb3Nl
cyBhcyBpdCB1c2VkIHRvIGJlIHJlcXVpcmVkIGJ5IHRoZSBnZW5lcmljIFZUIGNvZGUsIG9yCj4g
dGhleSBjb3BpZWQgaXQgZnJvbSBhbm90aGVyIGFyY2hpdGVjdHVyZSBpbiBvcmRlciB0byBidWls
ZCB0aGUgVkdBIGNvbnNvbGUKPiBkcml2ZXIgaW4gYW4gYWxsbW9kY29uZmlnIGJ1aWxkLiBUaGUg
bWlwcyBkZWZpbml0aW9uIGlzIHVzZWQgYnkgc29tZQo+IHBsYXRmb3JtcywgYnV0IHRoZSBpbml0
aWFsaXphdGlvbiBvbiBqYXp6IGlzIG5vdCBuZWVkZWQuCj4gCj4gTm93IHRoYXQgdmdhY29uIG5v
IGxvbmdlciBidWlsZHMgb24gdGhlc2UgYXJjaGl0ZWN0dXJlcywgcmVtb3ZlIHRoZQo+IHN0YWxl
IGRlZmluaXRpb25zIGFuZCBpbml0aWFsaXphdGlvbnMuCj4gCj4gUmV2aWV3ZWQtYnk6IEphdmll
ciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2aWVybUByZWRoYXQuY29tPgo+IFJldmlld2VkLWJ5OiBU
aG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KPiBBY2tlZC1ieTogRGluaCBO
Z3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+Cj4gQWNrZWQtYnk6IE1heCBGaWxpcHBvdiA8amNt
dmJrYmNAZ21haWwuY29tPgo+IEFja2VkLWJ5OiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQHJpdm9z
aW5jLmNvbT4KPiBBY2tlZC1ieTogR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+Cj4gU2lnbmVk
LW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiAtLS0KPiAgIGFyY2gvY3Nr
eS9rZXJuZWwvc2V0dXAuYyAgICAgICAgICB8IDEyIC0tLS0tLS0tLS0tLQo+ICAgYXJjaC9oZXhh
Z29uL2tlcm5lbC9NYWtlZmlsZSAgICAgIHwgIDIgLS0KPiAgIGFyY2gvaGV4YWdvbi9rZXJuZWwv
c2NyZWVuX2luZm8uYyB8ICAzIC0tLQo+ICAgYXJjaC9taXBzL2phenovc2V0dXAuYyAgICAgICAg
ICAgIHwgIDkgLS0tLS0tLS0tCj4gICBhcmNoL25pb3MyL2tlcm5lbC9zZXR1cC5jICAgICAgICAg
fCAgNSAtLS0tLQo+ICAgYXJjaC9zaC9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgIHwgIDUgLS0t
LS0KPiAgIGFyY2gvc3BhcmMva2VybmVsL3NldHVwXzMyLmMgICAgICB8IDEzIC0tLS0tLS0tLS0t
LS0KPiAgIGFyY2gvc3BhcmMva2VybmVsL3NldHVwXzY0LmMgICAgICB8IDEzIC0tLS0tLS0tLS0t
LS0KPiAgIGFyY2gveHRlbnNhL2tlcm5lbC9zZXR1cC5jICAgICAgICB8IDEyIC0tLS0tLS0tLS0t
LQo+ICAgOSBmaWxlcyBjaGFuZ2VkLCA3NCBkZWxldGlvbnMoLSkKPiAgIGRlbGV0ZSBtb2RlIDEw
MDY0NCBhcmNoL2hleGFnb24va2VybmVsL3NjcmVlbl9pbmZvLmMKClJldmlld2VkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+Cgo=
