From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Date: Tue, 13 Jun 2023 16:14:41 +0000
Message-ID: <b5febf204db2c2d080e32a9429a4265340091034.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
         <497e571e-e4de-7634-7da6-683599a4bbba@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672953; x=1718208953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0U2cwbkyUuTAI9fOh9arm1xJSPvXM/Vlz7KbWvXnSso=;
  b=kBQ8WasxZXYw80pKCevdG702+ZLJ5rV1yBxFIJ3k+etVsyFpnjVpMSPD
   JhCBcI4KVL43el5Dr3T33QW1uYQZy+mPmQjJ8rickmCUR1Fr9YJ6xh5lJ
   kSoQHhIDh2/F+bLJ50g0K+PlcMxu+aLyPUUjHfRUlS0sQ5/tE3lwUU45F
   pn2eHWhEqTBhNSm89+KB0HmRfe2cV/nPIJV7InIv1Z+yOhRnyX3UdXUDS
   ZJ/EMde4ZW9p32YTYdyHrCnPx6wuOtshQJHOoxVZ60wVGzbsSVTfrQyLP
   8rIMTmbvki7te2Rvj94VLkpL7jek7/ABRFhd9RhBZ88BQ9Foc2fwBFj/e
   Q==;
In-Reply-To: <497e571e-e4de-7634-7da6-683599a4bbba@redhat.com>
Content-Language: en-US
Content-ID: <7EE3FBC8E983814C9215D2E914896984@namprd11.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kcc@google.com" <kcc@google.com>, "Lutomirski, Andy" <luto@kernel.org>, "nadav.amit@gmail.com" <nadav.amit@gmail.com>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "david@redhat.com" <david@redhat.com>, "Schimpe, Christina" <christina.schimpe@intel.com>, "Torvalds, Linus" <torvalds@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>, "corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jannh@google.com" <jannh@google.com>, "dethoma@microsoft.com" <dethoma@microsoft.com>, "broonie@kernel.org" <broonie@kernel.org>, m
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "dinguyen@kernel.org" <dinguyen@kernel.org>, linuxppc-dev@

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE0OjI2ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gDQo+IEFja2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4N
Cg0KVGhhbmtzIQ0K
