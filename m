From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date: Thu, 01 Jun 2023 22:54:42 +1000
Message-ID: <87jzwngx65.fsf@mail.lhotse>
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
 <20230529111337.352990-2-maninder1.s@samsung.com>
 <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
 <87ilc8ym6v.fsf@mail.lhotse>
 <CANiq72nf-MC36hHzv0ZpR+qUyaf3mhF+rfqpMcVbw0AheuRBpA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685624085;
        bh=OZ/5HE/soAZZFHMXDiilpjDsIee5iu2+4q2X3qd67Kk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gzr/Hmhjs2KUDi4nnp0MTHzIyL0PHDDlwEtr+CBgyllamdBOtERawuTPq1+Z0snRe
         RqvCFjm/AWFD80J4BeLp2QSQym1ZXeBiTft476K8ziJUbnMOsjsA8RguD3AXyBM5ye
         BB8D+ZLSQhYU4+sMbj/eMXeZOxXpMmvnOSbuYx4SljrZQOjCTWzd6GgU2ijA91cw2e
         hBlD1wH6lVO9+LZrJWD78PbLEnkVDbcqxmqj/xz6NryKP4Qh8wL5EamqBP+0kxiavr
         heyBgrKUWteT0TNw6HQ7F6eykkAzJNWrx0xo+P2Vm3YnPQiCg8krOBryTkoo95eIfg
         HINee5Siuuv1g==
In-Reply-To: <CANiq72nf-MC36hHzv0ZpR+qUyaf3mhF+rfqpMcVbw0AheuRBpA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Maninder Singh <maninder1.s@samsung.com>, bcain@quicinc.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com, wedsonaf@google.com, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> On Thu, Jun 1, 2023 at 4:02=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.=
au> wrote:
>>
>> > Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
>> > used, but the name seems discarded? Can
>> > `kallsyms_lookup_size_offset()` be used instead, thus avoiding the
>> > usage of the buffer there to begin with?
>>
>> A few lines below it uses the modname, and AFAICS there's no (easy) way
>> to lookup the modname without also looking up the name.
>
> Hmm... I think you are looking at the `xmon_print_symbol()` one? I was
> referring to the `get_function_bounds()` one, where the `modname`
> parameter is `NULL` (and the `name` contents are not used, only
> whether it was found or not).

Yes you're right, apparently I can't read :}

cheers
