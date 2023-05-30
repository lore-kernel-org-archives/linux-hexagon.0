From: Maninder Singh <maninder1.s@samsung.com>
Subject: RE: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array
 size
Date: Tue, 30 May 2023 13:44:05 +0530
Message-ID: <20230530081405epcms5p879eeba2a521ff23fea57ce42bf913eac@epcms5p8>
References: <ZHWub0ibU7etLnXK@alley>
        <20230529052821.58175-1-maninder1.s@samsung.com>
        <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
        <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
        <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
        <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p8>
Reply-To: maninder1.s@samsung.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230530081605epoutp032e888f56ed123a45b78749a03eb9a563~j3c61-u2E1656016560epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685434565;
        bh=5ac7mcvUjipTjuyt2bSsLImVDWiscD6gA99NQK48iBs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Fnat8ZEMwWGH3IskToGqsOFf2j0fTLuLglIL46XCr39Wq+zqmZKhvm68EvCCpB/eW
         aX/OACM0Zbylw+ef6wgUCOYRWwkj/AB/VMK7pjBGqWCSIkglKUyDnp5yJQfgMR0taW
         k5L7RwARTUW5R0mk60USG/WlB9f4gMWnfGGaloC8=
Sender: Maninder Singh <maninder1.s@samsung.com>
In-Reply-To: <ZHWub0ibU7etLnXK@alley>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Petr Mladek <pmladek@suse.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, "keescook@chromium.org" <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "bcain@quicinc.com" <bcain@quicinc.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>, "ustavoars@kernel.org" <ustavoars@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, "ojeda@kernel.org" <ojeda@kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

Hi Peter,

>
> The best solution would be to pass the buffer size as an extra
> parameter. Especially when some code passes buffers that are
> allocated/reserved dynamically.
> 
> Sigh, I am not sure how many changes it would require in kallsyms
> API and all the callers. But it would be really appreciated, IMHO.
> 

yes we already prepared size changes 5-6 months back:

https://lore.kernel.org/lkml/YonTOL4zC4CytVrn@infradead.org/t/

[PATCH 1/5] kallsyms: pass buffer size in sprint_* APIs

But at that time  new API development(for replacement of seq_buf) was in progress and we decided to wait for that completion.

https://lore.kernel.org/r/20220604193042.1674951-2-kent.overstreet@gmail.com

https://lore.kernel.org/r/20220604193042.1674951-4-kent.overstreet@gmail.com

As I checeked these APIs are not pushed to mainline.

we will try to prepare new patch set for kallsym changes again 
with seq_buf to take care of length argument.

Thanks,
Maninder Singh
