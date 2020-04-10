Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9811A431C
	for <lists+kvmarm@lfdr.de>; Fri, 10 Apr 2020 09:44:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D0094B1D2;
	Fri, 10 Apr 2020 03:43:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lqlasw+E98AE; Fri, 10 Apr 2020 03:43:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5865A4B1BA;
	Fri, 10 Apr 2020 03:43:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E45FD4B0FB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Apr 2020 00:43:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEKcBSuz2OsI for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Apr 2020 00:43:47 -0400 (EDT)
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B44D34B0F4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Apr 2020 00:43:47 -0400 (EDT)
Received: by mail-pf1-f196.google.com with SMTP id q3so565809pff.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Apr 2020 21:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rRpbgDANI8vDrTtjTJENSHjACfupvu/DpiY4PQxKbDI=;
 b=nIpqgyHbvMAMKy2VqyXmbM4uLzHVz6C/g9PZ9c1m/tpwLKwNlJb3ega6O39WQRQdK9
 pAWpux6ra2ePXgTVk9g67BthOpd9jgnA8+9mrG/lMIq1KkFEtM5uNeMnZlGDj/WWWP1m
 g1IvF9u5qL1fFaZokOOB/RFk92NAH64nxg906PqfXBPBjv5W+3OMZMhoDEZ1ScHCE0Ah
 NS+lH2lXeSLvQKjNjPgLUwrFW0iwIXGkvaLhYtXOLm1vYjaGGW1R/ZSbtVuXQZtjDaWx
 e1E9byWCc8FIyQ4SIcouIS0Sr/6WA/aC3oMRo5Sd9ObBa5vSDyQ4vgr8A41xf7n+tPOO
 IRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rRpbgDANI8vDrTtjTJENSHjACfupvu/DpiY4PQxKbDI=;
 b=EDeinGm41wRGW1vVfyFYVP/ns6AivLjrkCVnMlKWcGjRwxXHtWOHaB4Zu9p+LqWPHs
 hYM1v9PYN18OyTJ7N4vBwF4u1nXi82iFtDpE94bwKDTUiGxt+F7dpNnJfU25wVl95OAR
 awY5YBb/0WzTj7xdyEjyBIHpCo2zYapKYeKIipj7+AtUjRgBc29qbf+ocj8OjRRmZos+
 GPer8mtACV/0N/ENeNY9G4ODrEaG3tkrWwX4v1eykk3Nr2GZlVEoR34ZYSqR4SdfwqdY
 mAcz0Qj7mKu+Tnf46eoe/88p56mu3jeHTG5LvVaRC3hwlIM2Jewt86QYITUPOmkAkiz0
 aR+w==
X-Gm-Message-State: AGi0PuaGJiOdCho0ReTLNqgqqidRnwd65iedglRak4xd/IH9O+ltan7r
 inVq0pg+eleDeuT2iudl2CCpz/pAINnFRWOGFw8=
X-Google-Smtp-Source: APiQypKnPTbJEfArWAgzMfDQYIpR0U8LgpeRAwObfBfYM1F9/inERKEjnh80fZP3e7G857uo1syih/ToxJUnuVb7UVs=
X-Received: by 2002:a62:648f:: with SMTP id y137mr3358952pfb.199.1586493826879; 
 Thu, 09 Apr 2020 21:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEX+82KTJecx_aSHAPN9ZkS_YDiDfyEM9b6ji4wabmSZ6O516Q@mail.gmail.com>
 <c86002a6-d613-c0be-a672-cca8e9c83e1c@intel.com>
In-Reply-To: <c86002a6-d613-c0be-a672-cca8e9c83e1c@intel.com>
From: Javier Romero <xavinux@gmail.com>
Date: Fri, 10 Apr 2020 01:43:35 -0300
Message-ID: <CAEX+82J+xRA1B10ApcviZ04=ZZ+YNth83p428bHgOHmaV1iTuA@mail.gmail.com>
Subject: Re: Contribution to KVM.
To: like.xu@intel.com
X-Mailman-Approved-At: Fri, 10 Apr 2020 03:43:52 -0400
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

SGkgTGlrZSBYdSwKClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIHRvIGFuc3dlci4KCk9mIGNvdXJz
ZSBJIGNhbiBhbHNvIHRlc3QgS1ZNIG9uIGFuIEludGVsIFBsYXRmb3JtIGlmIHRoaXMgY2FuIGJl
CnVzZWZ1bCwgaGF2ZSBhIFBpeGVsYm9vayBsYXB0b3Agd2l0aCBhIENvcmUgaTcgcHJvY2Vzc29y
IGFuZCAxNiBHQiBvZgpSQU0gYXQgZGlzcG9zYWwgOkQKClRoYW5rcyBmb3IgeW91ciBhdHRlbnRp
b24uCgpSZWdhcmRzLAoKCkphdmllciBSb21lcm8KCgpFbCB2aWUuLCAxMCBhYnIuIDIwMjAgYSBs
YXMgMDozNCwgWHUsIExpa2UgKDxsaWtlLnh1QGludGVsLmNvbT4pIGVzY3JpYmnDszoKPgo+IE9u
IDIwMjAvNC8xMCA1OjI5LCBKYXZpZXIgUm9tZXJvIHdyb3RlOgo+ID4gSGVsbG8sCj4gPgo+ID4g
ICBNeSBuYW1lIGlzIEphdmllciwgbGl2ZSBpbiBBcmdlbnRpbmEgYW5kIHdvcmsgYXMgYSBjbG91
ZCBlbmdpbmVlci4KPiA+Cj4gPiBIYXZlIGJlZW4gd29ya2luZyB3aXRoIExpbnV4IHNlcnZlcnMg
Zm9yIHRoZSBsYXN0IDEwIHllYXJzIGluIGFuCj4gPiBJbnRlcm5ldCBTZXJ2aWNlIFByb3ZpZGVy
IGFuZCBJJ20gaW50ZXJlc3RlZCBpbiBjb250cmlidXRpbmcgdG8gS1ZNCj4gV2VsY29tZSwgSSdt
IGEgbmV3YmllIGFzIHdlbGwuCj4gPiBtYXliZSB3aXRoIHRlc3RpbmcgYXMgYSBzdGFydCBwb2lu
dC4KPiBZb3UgbWF5IHRyeSB0aGUgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vdmlydC9r
dm0va3ZtLXVuaXQtdGVzdHMuZ2l0Cj4gYW5kIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bSBp
biB0aGUga2VybmVsIHRyZWUuCj4gPgo+ID4gSWYgaXQgY2FuIGJlIHVzZWZ1bCB0byB0ZXN0IEtW
TSBvbiBBUk0sIEkgaGF2ZSBhIFJhc3BiZXJyeSBQSSAzIGF0IGRpc3Bvc2FsLgo+IElmIHlvdSB0
ZXN0IEtWTSBvbiBJbnRlbCBwbGF0Zm9ybXMsIHlvdSB3aWxsIGRlZmluaXRlbHkgZ2V0IHN1cHBv
cnQgZnJvbSBtZSA6RC4KPgo+IFRoYW5rcywKPiBMaWtlIFh1Cj4gPgo+ID4gVGhhbmtzIGZvciB5
b3VyIGtpbmQgYXR0ZW50aW9uLgo+ID4KPiA+IEJlc3QgUmVnYXJkcywKPiA+Cj4gPgo+ID4KPiA+
IEphdmllciBSb21lcm8KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUK
aHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
