From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: Re: [patch v2 00/35] Hexagon: Add support for Qualcomm Hexagon
 architecture
Date: Tue, 30 Aug 2011 15:48:33 -0500
Message-ID: <20110830204833.GA7047@codeaurora.org>
References: <20110830190729.923334292@codeaurora.org>
 <CAOJsxLHrC1Tuf9j_Xnq9DHe15zvaB9kUWiFSxPgi4urUUO3bhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOJsxLHrC1Tuf9j_Xnq9DHe15zvaB9kUWiFSxPgi4urUUO3bhQ@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Pekka Enberg <penberg@kernel.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, Aug 30, 2011 at 11:18:24PM +0300, Pekka Enberg wrote:
> On Tue, Aug 30, 2011 at 10:07 PM, Richard Kuo <rkuo@codeaurora.org> w=
rote:
> > Thanks to everyone for their comments/feedback! =C2=A0If I missed a=
nything
> > or there's something else that needs cleanup, please let me know.
>=20
> Are there any publicly available references for the architecture?
> Googling for "Qualcomm Hexagon" doesn't seem to find anything
> interesting.

The main developer page is at=20
https://developer.qualcomm.com/hexagon-processor

The specs listed there include:

|> Hexagon V2 Programmer=E2=80=99s Reference Manual (80-NB419-1)
|> https://developer.qualcomm.com/file/5117/80-nb419-1ahexagonv2program=
mersref.pdf
|> Describes the Hexagon V2 processor architecture and instruction set.
|>=20
|> Hexagon Application Binary Interface Specification (80-NB419-2)
|> https://developer.qualcomm.com/file/5119/80-nb419-2ahexagonabispec.p=
df
|> Describes the application binary interface (ABI) for the Hexagon V2,=
 V3, and V4 processor versions. Topics covered include the hardware rep=
resentation of C data types, software stack configuration, parameter pa=
ssing, register usage across function calls, and C++ exception handling=
=2E
|>=20
|> Hexagon Virtual Machine Specification (80-NB419-3)
|> https://developer.qualcomm.com/file/5118/80-nb419-3ahexagonvirtualma=
chinespec.pdf
|> Describes the Hexagon Virtual Machine (HVM), a software abstraction =
layer which enables multiple operating systems and other clients to exe=
cute concurrently on a single Hexagon processor, through the virtualiza=
tion and partitioning of physical hardware resources.
=20
Access to these seems to require registration ...

--linas

--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
