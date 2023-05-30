From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 14:59:15 +0200
Message-ID: <CANiq72nTqbof=SThq-PRhz=ks2WRvdUXBzJoesyXUmB2KB5pmA@mail.gmail.com>
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451566; x=1688043566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUns/AgpqXLAWkbT9nsAikv8VufNiDnQgvXLGdGlTyQ=;
        b=OmrsvIF7hVLwpUuwLixBRJ6u4vsZnI03aBYhM18P6OCXa/SkjvHSiOjWX6yU2Q+gVi
         hZSYPF3eITVKkYItFYr40i+B779YjeABUR1SkuuWHeOyReu71Ytc8ggaIRkhc0xEM/if
         4VJTLo1GjdIk59fADOfd1uFtp0DXUobZ2kIb1rsy+zJyeHL48aoL2Dy+fG3jFt9R0ldN
         gGySuiRHmb2P+Bx+5K/TX2xeZ4KYSiIdtYy3pIyxAJoOuZwR1vFnfswavB3CyexFxUMO
         CyvNnOx/Od3r2WXffSaYZum9hThqDE6T/s2Pvq0DSbvGqtj9N+4juL1VKBfGT3Tq++hv
         89oA==
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
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
To: Maninder Singh <maninder1.s@samsung.com>
Cc: nathanl@linux.ibm.com, bcain@quicinc.com, keescook@chromium.org, gary@garyguo.net, pmladek@suse.com, ustavoars@kernel.org, linux-kernel@vger.kernel.org, Onkarnath <onkarnath.1@samsung.com>, wedsonaf@google.com, npiggin@gmail.com, alex.gaynor@gmail.com, linux-hexagon@vger.kernel.org, ojeda@kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon, May 29, 2023 at 1:14=E2=80=AFPM Maninder Singh <maninder1.s@samsung=
.com> wrote:
>
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
>
> Thus array size should be KSYM_NAME_LEN.
>
> for hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
>
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to =
512")
>
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

With the updated commit hash:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
