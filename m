Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 907114711AC
	for <lists+kvmarm@lfdr.de>; Sat, 11 Dec 2021 06:18:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EBC504B202;
	Sat, 11 Dec 2021 00:18:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@intel.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@intel.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkofPyDWt41f; Sat, 11 Dec 2021 00:18:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C2074B201;
	Sat, 11 Dec 2021 00:18:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4500B4B1AF
 for <kvmarm@lists.cs.columbia.edu>; Sat, 11 Dec 2021 00:18:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9GYnVtBbbwBf for <kvmarm@lists.cs.columbia.edu>;
 Sat, 11 Dec 2021 00:18:11 -0500 (EST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 96DE84B1F4
 for <kvmarm@lists.cs.columbia.edu>; Sat, 11 Dec 2021 00:18:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639199891; x=1670735891;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SY8y/3fJIDmmaGzIrj+lOuOwIioJ3PXbybZOodh8JN4=;
 b=Chfpf5myLy3tfuzNmDw6phS2eIbAovTQRtDVeAyrmChPTJmI5H9kfYnY
 xxK869293vvzBETRDyoFIws4nNAx3OGZokob9V8P3kOFQ2r7Ze6wrpREL
 DREftmEYtHrCM1DAxUace5ruUCCMYx3+3VnoUcb9O3UfVhzkF1ojZOuAY
 eRs4ptteLLr+PQdeUe6hYfvukbtAcP1FVmE5rod0dRLsHHmTkuqvCbw8D
 GVhOALcRVI/NhmZAW9tKuiItPs7EzLR+0xSsx6OL13exbgzWTsv/GO32B
 uAqn/7s6+ow8jjV8XOlHa+2vU4liasuFMiH4TknA4V/9w2l6OZUrrD/0a w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="219195322"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; d="scan'208";a="219195322"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 21:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; d="scan'208";a="544215309"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga001.jf.intel.com with ESMTP; 10 Dec 2021 21:18:10 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 21:18:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 21:18:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 10 Dec 2021 21:18:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 10 Dec 2021 21:18:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvKJaYOGGv1DUvBOIul01GMelYDRkA6Q5UShsY79b4Nc+uUwKXlZtiOEtwMPK2VAuOrn8xBYav01fpUCcBa1nt/y20OUGO712V5quEXEzxulM/Gpiuuqf0BgbRazQOc/nfCTTPeAkHS4ellk0roDlr5gKdqwaWmnbpPItSz0vQ6oiNMTAPl+suKsXw2L3Zi9yY7B+73rws4oFuYkCk6YSHc314Pf85Be00be5hLj0Q0aMaxZprkwRQdTGoWoCi2rAZZcGl7dkfD0YQZNxIWJQBPfQQ4lDgcPxIBCXn/rcM9xO+VlIvO2liHPtrbOEtFuc9tZ6lbJcG6b9+BJWX1Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY8y/3fJIDmmaGzIrj+lOuOwIioJ3PXbybZOodh8JN4=;
 b=Hzbgb1Y9i41wGTbZMjhcLE4govGiLbB3Re2EGAQJG/HIFX5YBHcBDR002KOUmlAqYPTJL8D3VJJg26rnzic+gMwApRZooJvUWJrpGFZ52eqKBSlfgM+R8bws+ObSf18tZXmRW0RfbV2AHHWfDd6oiBp9YX/2CS1RJiwQFJ52Me6cPbZ1w2zqKnMN8mz+UHU+/ya9I6rEArXI5GKbRDj9mDL87c4LVLOMaMjeHAFxvfuAVyZq4zZee3BymhtBTP+MrCDHcwnMXutrTL96oYbE43DcFSMRl+eFMqk6Ic/qSoOxcPuVkF3AuO2wkOoUGwyRcQL9LImbUjlZtfGtjqYLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY8y/3fJIDmmaGzIrj+lOuOwIioJ3PXbybZOodh8JN4=;
 b=GrOGTy1/7xhm3jaRzzewJY4XCoKB/OHz6yioiRq3Fs8LA0ZHpWFT1jhdGbUcKdoQQTTEpSnYUgFyC5uibBmUi4mGkwNPS4lUrBM637esCrMbEDhSRZkel2aQ9iGmvROCjRGFVz7EABNke5pDrBe5HQIkMReGuG2zA3hxh56NOVk=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5371.namprd11.prod.outlook.com (2603:10b6:408:11c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Sat, 11 Dec
 2021 05:18:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Sat, 11 Dec 2021
 05:18:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
Thread-Topic: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
Thread-Index: AQHXyx+9zoVf6ec36EaoAw6mFm2RjKwlh1WAgAGLFwCAARJNAIAAUNaAgABaKgCAAEnegIAAE6oAgACHsjCAABVZoIAAzVeAgAED4rCAAGBlgIAA7M0AgAAddaA=
Date: Sat, 11 Dec 2021 05:18:04 +0000
Message-ID: <BN9PR11MB527616BAA59483849CDCB2478C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
 <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
 <20211208125616.GN6385@nvidia.com> <YbDpZ0pf7XeZcc7z@myrica>
 <20211208183102.GD6385@nvidia.com>
 <BN9PR11MB527624080CB9302481B74C7A8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <BN9PR11MB5276D3B4B181F73A1D62361C8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211209160803.GR6385@nvidia.com>
 <BN9PR11MB527612D1B4E0DC85A442D87D8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210132313.GG6385@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e015ded7-442a-4ad9-ca85-08d9bc659c4d
x-ms-traffictypediagnostic: BN9PR11MB5371:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB53713D4DC6F3E2DD1275F4B08C729@BN9PR11MB5371.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Luvnk2IEzRytcF4whCzdSwNisXUR+h9mG9u4Hu1sjAfyI1mDp3IUruisG+i7LeexCkD0pAr5rEOh1C1yqTtyEOdyVAz3Lk0/vKpF3HmMpvlyLskJnynXm/MIbRJQRXx0Ld58wHF7ZhSdD0NVN0S0dyWDyrsR3S/1racV13OhlnsNhvKk+4eURefrIWRPJE9UYQd4l32ZwjQMAEFiXNBzlrhiJe9Z/Kb/0/85waoaDr/B9KKAOqexJDcN2dCBU2/mcY8djG4oxc6AfpjdsibIcmVGaK2UP4QIVxeHBw6EMDZmLjxZgMCt/+H6eQSigXVRXyg9xACrIH/fAGtYYxye2DALZOc4+EmT+ppcD6qzPDdLFrzigERdJQLmsf939tUqZNmTBnXrmhqH2Ugeuyuw1Q52L+BQLk1hooyEYwzGzQl8NXPnte/lUfNXv1k1SbfWhgvhSTQM5DzqOCVR4qRuqrlVNYyr1i5AQLGvmeLRKzmPFasoj5RSLCyLfpONoQO4HemZNOS+n5TiL4Ky0RxDmpTS489yK7VV9OmXUFchpCzUXLiFIgeX5ZopzcM9RQDlFnjJlnIbAKtYJPqsvwcnZpjQzUI0WIgrvPccjQxWhsD/kJ/uURwDGrMprlkbMGQlQrNVlaqOhYQp93lnHW9+OlKpG1Ns396v3d02EmEZMesEmWvNyuHsmrCL4sfv0LDoeI+gyrOAI7x+/jHmr6+wIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(66446008)(66556008)(66476007)(7696005)(64756008)(8676002)(38070700005)(33656002)(6916009)(71200400001)(76116006)(52536014)(508600001)(122000001)(8936002)(55016003)(38100700002)(5660300002)(7416002)(26005)(6506007)(4326008)(4744005)(82960400001)(186003)(2906002)(316002)(86362001)(9686003)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1dySHYzVVNPWk9MaERlVnNBSndabENIOXlNMUV1ZDgyeE5EUFcyUTVNQUpB?=
 =?utf-8?B?VmJqOHpTUncyWkRYQ2Nid01DSFIxNy8xaHVTL1dXWXNENjdJUDNmZmgybC9J?=
 =?utf-8?B?RVRlQUJnTkZKVjRKOVh1UllNUHNXZGMxS2F2cnQ0aDBiY2hnTkp2QXRRN0hX?=
 =?utf-8?B?YkQ3QS9wSnk1MmRSUGJIRC82U1F3aXBpOU9YZEY4T2ROaUZKaHBrUHhaTlMx?=
 =?utf-8?B?RzIveFFGYXRScnNiT3J6dFA2UmlnL0Z4TE1MWHRITTB5dVRtdm5PUllCM2FW?=
 =?utf-8?B?YlNWTitkeHVtYzBmZWJJaTJoaEVmNEExM2xycGF0ZlFmVUc1L0VtQ2dNSXhP?=
 =?utf-8?B?bEhDT3k2TlEzczAwanNvZXh3dDhqM1R6cUlzWnY5TWtUcW4zQmFUaDJEWmQ3?=
 =?utf-8?B?RmMvUGVOclY0ZUJSd2FkOGxkYnFhVUZ3RnJrM05hNE9lOGpNUyswNUQ3a01q?=
 =?utf-8?B?SmtYZ1czMk9kUkFHdW9JeXdBNGtQZlVoWkVKaEJKbGV2Z1BjQWJXYTFVQndF?=
 =?utf-8?B?c0tiWnNhdUxnaThJeWI3ZkJYMkUwL1plRkorQS9PZnIxdDhFVFR6SVU0ZGxB?=
 =?utf-8?B?bmtsTUEvditYSHVjMEFNMHg3Q2xqUlJVUEtzVmhIYzNFa2JqZnRSanBqYnRQ?=
 =?utf-8?B?WDFScWhCMUhsVC81SkhnR0lwQ21vV0JXOUtLbnJ2MzVFaGQ3MEZyV3lodnhw?=
 =?utf-8?B?aXhib0NMZEpDaUVvbjdBV1pzSWJMbnhoei81cnQ2eUMxbm9OdXBkQm4rSUZ6?=
 =?utf-8?B?MTUxMXpNMm9INDlBUnA4WEJ5QUt0NVRBN0N0SDkySS9IZXU3U1NrS2EyMm5Q?=
 =?utf-8?B?aE85VVBDVkM0TWFWS2hHckxJWGN0djdKRUVCcysvam9zUGh0TWtLYUd6UE05?=
 =?utf-8?B?M3k1UzFSMzNJbklaTU5YbHljeWFIQWtyQjFMeG9JL3oxWkJsVFlOTGtnZmRS?=
 =?utf-8?B?N05YbGNCTTVKQ3ZRaDFJSjhYTFdUOW5SQXJEK3lUZ3RJY2lhck1saWxrOHJw?=
 =?utf-8?B?L0dvY05TVGdwZ29UbWN3MTlvaU1IbzVudlNacmFydml1SWxmWE4rU1JGalN6?=
 =?utf-8?B?Y1ROb2tGKzJLNE9STlI4cTVhVXJlQkhxaEx2akRaM2p0QmJPMTg1czk4WFRP?=
 =?utf-8?B?NzU5aG9pOXFodTRpd3diVWhRblNPZFJScTA5NkFnTFVBNXdZcEY4a0ZDMEZI?=
 =?utf-8?B?aEZTWDNTL21kRHBSUDNVTlVQQW5FYzZ4OUVDeDkwREMvRFIxTU9rRVhSM2k5?=
 =?utf-8?B?ZnY5QXJ3NUY2bGFUcEJra0dGdTRmRkpVTGxWTllYVW54dGxmSUd4V2JCUWdY?=
 =?utf-8?B?bGJBME00UGpwUXpQaDFBT2JoaFlmMkFCSWs0L1E1MVpLTGJGWkgrR2JUYmhJ?=
 =?utf-8?B?NWNpVWkrT2c3YU1TVGUxa1FXOGxMNkhicEd3aGduUkFnZTdidHlUY25IQ05a?=
 =?utf-8?B?Y1pZeHFsSC9xZDdzbzlaYUk4K1YxNHFjMkxocHhtZVJGaGRQdmdlVlFjT2hR?=
 =?utf-8?B?U0VXMDQ1WklYZTBlWGhjMk1aR3V0b2Z6ZkRVZFNWVW01dnVIKzE3UHp2dkZs?=
 =?utf-8?B?V2habDkvQWFNWVVzWWw3cGJTQ09qdGxkTzU2K2pnbTh1N0NFR3k4bzZtR3o2?=
 =?utf-8?B?VHdRRG05SkQ2SzRvZkF5MkVvY1JZcUExM3dML0MzUEtIUVdvTldoUmwwSHd6?=
 =?utf-8?B?ckNRMVI1dXRuQ1NMSitYLzFlWHNER1c1YVVIemRnMDZIbExMUVFSMnp5SFRU?=
 =?utf-8?B?dkZ0QzJBYUViZkt2UWNqNGZhTGd5ejlnOFV4Zk40TWt3VDdnT3FGZlJLKzY1?=
 =?utf-8?B?VTZFcExzR2N4czdmaHpyMzBBRU5GOGhubzhrMkkvaXBFT0ZQQS9rWGFOb0ZU?=
 =?utf-8?B?Q29ic3RJQUZmMzZCQjNHZnUwMGltSDRvaVI1OTNtazhia0xVQlFPbUlqNnhj?=
 =?utf-8?B?V056Ym9wL2hCOXlmOWs2N21WaThGT1VraFRVVkpjVzFPazQwUXNndWdDMUha?=
 =?utf-8?B?UGswWXJiS1ZKbElTdnM0eHFJaUtxQ1k0UTNva3pLVUlwNWpGUUphYk5iK0tE?=
 =?utf-8?B?TU85SGlZRkJFRmpGbXQzQjMzRHhsZm54b1kzbitNSGZoNmFIWjNQZ0Z0bjVv?=
 =?utf-8?B?NFQ3VVRUdmJFL3p5cmV1b21tQjFlZUtpU0FiMlBSMHlXYWhZcmk4VTVMa3pu?=
 =?utf-8?Q?ddeb3dIcytzlfI5/oC6AruY=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e015ded7-442a-4ad9-ca85-08d9bc659c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 05:18:04.8214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TT1E/gbT0X5oyJzrhvRt7so37ugdGRrDaGeJA7KDSjHvumALjQSWuWIepO0/uKZTcUpu0XcnhDJDFW0tODpBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5371
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vsethi@nvidia.com" <vsethi@nvidia.com>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "wangxingang5@huawei.com" <wangxingang5@huawei.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

> From: Tian, Kevin
> Sent: Saturday, December 11, 2021 11:58 AM
>
> This might be the only open as I still didn't see why we need an
> explicit flag to claim a 'full device' thing. From kernel p.o.v the
> ARM case is no different from Intel that both allows an user
> page table attached to vRID, just with different format and

obviously this is 'RID' to not cause further confusion since it
talks about the kernel p.o.v

> addr width (Intel is 64bit, ARM is 84bit where PASID can be
> considered a sub-handle in the 84bit address space and not
> the kernel's business).
> 
> and ARM doesn't support explicit PASID attach then those calls
> will fail for sure.

Thanks
Kevin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
