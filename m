From: Maninder Singh <maninder1.s@samsung.com>
Subject: RE: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array
 size
Date: Mon, 29 May 2023 16:27:07 +0530
Message-ID: <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
References: <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
        <20230529052821.58175-1-maninder1.s@samsung.com>
        <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
Reply-To: maninder1.s@samsung.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230529110838epoutp040abcec22e9e03e0a6e9ab9131ffc9dd1~jmKS17_450246702467epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685358518;
        bh=dZVfotqZFrsokbs+wqGDWxA2HIP1xtUvpW9KT5S6V/g=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mSik56PfWyps25P0F27uNOkKOxyJzsXVnUURn9lmV4y5b8ai/sDKbVAoVFHQsb3WE
         lotiS4me6f9y3aDafyDvpHVV1abOM/qOM6tC+SZ4G3hAOE2CXOTkFA5kcxXoyjaYWV
         idqSz0qyNhYihTZJazdfDEInFl+6L/tvKQFvV7HY=
Sender: Maninder Singh <maninder1.s@samsung.com>
In-Reply-To: <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "bcain@quicinc.com" <bcain@quicinc.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "keescook@chromium.org" <keescook@chromium.org>, "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>, "ustavoars@kernel.org" <ustavoars@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, "ojeda@kernel.org" <ojeda@kernel.org>, "pmladek@suse.com" <pmladek@suse.com>, "wedsonaf@google.com" <wedsonaf@google.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Onkarnath <onkarnath.1@samsung.com>

Hi,

>>
>> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
>> writes on index "KSYM_NAME_LEN - 1".
>>
>> Thus array size should be KSYM_NAME_LEN.
>>
>> for powerpc and hexagon it was defined as "128" directly.
>> and commit '61968dbc2d5d' changed define value to 512,
>> So both were missed to update with new size.
>>
>> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")
>> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

> Thanks for this!
> 
> There is no `From:` at the top. Since I cannot locate the patch in
> Lore, did you mean to put both of you as authors perhaps? In that
> case, please use a `Co-developed-by` as needed.
> 

I Will add co-developed-by` tag.
because this change was identified while we were working on kallsyms some time back.
https://lore.kernel.org/lkml/YonTOL4zC4CytVrn@infradead.org/t/

this patch set is pending and we will start working on that again, so i thought better
to send bugfix first.

> Perhaps it is a good idea to submit each arch independently, too.
> 

ok, I will share 2 separate patches.

> The changes themselves look fine on a quick inspection, though the
> `xmon.c` one is a global buffer (and there is another equally-sized
> buffer in `xmon.c` with a hard-coded `128` constant that would be nice
> to clarify).

Yes, I think second buffer was not related to kallsyms, so I have not touched that.

Thanks,
Maninder Singh
